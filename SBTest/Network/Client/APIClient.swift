//
//  APIClient.swift
//  SBTest
//
//  Created by Muhammad Wahab on 02/11/2023.
//


import Foundation
import Alamofire

class APIClient {
    
    static var shared = APIClient()
    
    private init() { }
    
    private var sessionManager: Alamofire.Session?
    
    func fetchDataWithRequest<ResponseType>(request: ApiRequest<ResponseType>, responseHandler: @escaping (ApiResponse) -> Void) {
        
        let  completeUrl = request.serviceUrl() + request.apiPath() + request.apiVersion() + request.apiLanguage() + request.apiResource() + request.endPoint()
        var urlRequest = URLRequest(url: URL(string: completeUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!)
        
        let userDefaults = UserDefaults.standard
        
        urlRequest.httpMethod = request.requestType().rawValue
        if request.requestType() == .post || request.requestType() == .patch
            || request.requestType() == .put || request.requestType() == .delete {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        else if request.requestType() == .get
        {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
            urlRequest.setValue("Bearer \(Constant.authToken)", forHTTPHeaderField: "Authorization")
        }
        if request.parameters() != nil {
            if request.requestType() != .get {
                urlRequest.httpBody = try?JSONSerialization.data(withJSONObject: request.parameters()!, options: [])
            }
        } else if request.arrayParameters() != nil {
            urlRequest.httpBody = try?JSONSerialization.data(withJSONObject: request.arrayParameters()!,
                                                             options: JSONSerialization.WritingOptions.prettyPrinted)
        }
        
        URLCache.shared.removeCachedResponse(for: urlRequest)
        URLCache.shared.removeAllCachedResponses()
        URLCache.shared.removeCachedResponses(since: Date())
        let queue = DispatchQueue(label: "com.response-queue", qos: .utility, attributes: [.concurrent])
        AF.request(urlRequest)
            .validate(statusCode: 200..<201)
            .responseData(queue: queue, completionHandler: { (response) in
                
                switch(response.result) {
                case .success:
                    self.showRequestDetailForSuccess(responseObject: response)
                    if response.data != nil && !response.data!.isEmpty {
                        self.handleSuccessResponse(request: request, response: response, responseHandler: responseHandler)
                        
                    } else {
                        responseHandler(self.failureStatusMessage())
                    }
                    
                case .failure :
                    self.showRequestDetailForFailure(responseObject: response)
                    self.handleErrorResponse(response: response, responseHandler: responseHandler)
                }
            })
    }
    
    func uploadDataWithRequest<ResponseType>(request: ApiRequest<ResponseType>, responseHandler: @escaping (ApiResponse) -> Void) {
        let completeUrl = request.serviceUrl() + request.apiPath() + request.apiVersion() + request.apiLanguage() + request.apiResource() + request.endPoint()
        // print("Request URL : \(completeUrl)")
        
        let userDefaults = UserDefaults.standard
        var headers = HTTPHeaders()
        
        let queue = DispatchQueue(label: "com.response-queue", qos: .utility, attributes: [.concurrent])
        AF.upload(multipartFormData: request.multiPartParameters(), to: completeUrl, method: Alamofire.HTTPMethod(rawValue: request.requestType().rawValue), headers: headers).uploadProgress(queue: .main) { (progress) in
            print("Upload Progress: \(progress.fractionCompleted)")
            
        }
        .validate(statusCode: 200..<201)
        .responseData(queue: queue, completionHandler: { (response) in
            
            switch(response.result) {
            case .success:
                self.showRequestDetailForSuccess(responseObject: response)
                if response.data != nil && !response.data!.isEmpty {
                    self.handleSuccessResponse(request: request, response: response, responseHandler: responseHandler)
                    
                } else {
                    responseHandler(self.failureStatusMessage())
                }
                
            case .failure :
                self.showRequestDetailForFailure(responseObject: response)
                self.handleErrorResponse(response: response, responseHandler: responseHandler)
            }
        })
    }
    
    
    
    private func handleErrorResponse(response: AFDataResponse<Data>, responseHandler: @escaping (ApiResponse) -> Void) {
        guard let error = response.error else {
            responseHandler(self.failureStatusMessage())
            return
        }
        let code = error.responseCode
        
        
        if code == 401 {
            
            var message: String = error.localizedDescription
            
            if let data = response.data {
                let respJson = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                message = (respJson?["message"] as? String) ?? ""
            }
            DispatchQueue.main.async {
                responseHandler(self.failureStatusMessage(message))
            }
            
        } else if(code == NSURLErrorNotConnectedToInternet || code == NSURLErrorCannotFindHost) {
            DispatchQueue.main.async {
                responseHandler(self.failureStatusMessage("The internet connection appears to be offline."))
            }
            
        } else if(code == NSURLErrorTimedOut) {
            DispatchQueue.main.async {
                responseHandler(self.failureStatusMessage("The internet connection appears to be offline."))
            }
            
        } else {
            DispatchQueue.main.async {
                //responseHandler(self.failureStatusMessage("We are trying to connect, please try again later.."))
                
                
                
                do {
                    let respJson = try JSONSerialization.jsonObject(with: response.data!, options: []) as! [String: Any]
                    let mess = (respJson["message"] as? String) ?? ""
                    
                    if mess == ""
                    {
                        responseHandler(self.failureStatusMessage("We are trying to connect, please try again later.."))
                    }
                    else
                    {
                        
                        responseHandler(self.failureStatusMessage((respJson["message"] as? String) ?? ""))
                    }
                    
                   
                } catch {
                    DispatchQueue.main.async {
                        //responseHandler(self.failureStatusMessage())
                        responseHandler(self.failureStatusMessage("We are trying to connect, please try again later.."))
                    }
                }
                
                
                
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    private func handleSuccessResponse<ResponseType: Codable>(request: ApiRequest<ResponseType>, response: AFDataResponse<Data>, responseHandler: @escaping (ApiResponse) -> Void) {
        
        
        let statusMessage = successStatusMessage()
        statusMessage.message = ""
        statusMessage.success = false
        
        statusMessage.success = true
        self.parseDataFromResponse(request: request, statusMessage: statusMessage, respJson: response.data!)
        
        responseHandler(statusMessage)
        
    }
        
    
    private func parseDataFromResponse<ResponseType: Codable>(request: ApiRequest<ResponseType>, statusMessage: ApiResponse, respJson: Data) {
        do {
            
                let jsonDecoder = JSONDecoder()
                let objData = try jsonDecoder.decode(ResponseType.self, from: respJson)
                statusMessage.data = objData as AnyObject
            
        
            
        } catch let error {
            //print(error.localizedDescription)
            print(String(describing: error))
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    private func showRequestDetailForSuccess(responseObject response : AFDataResponse<Data>) {
        #if DEBUG
        print("\n\n\n ✅ ✅ ✅ ✅ ✅  ------- Success Response Start -------  ✅ ✅ ✅ ✅ ✅ \n")
        print(""+(response.request?.url?.absoluteString ?? ""))
        print("\n=========   allHTTPHeaderFields   ========== \n")
        print("%@",response.request!.allHTTPHeaderFields!)
        
        if let bodyData : Data = response.request?.httpBody {
            let bodyString = String(data: bodyData, encoding: String.Encoding.utf8)
            print("\n=========   Request httpBody   ========== \n" + bodyString!)
            
        } else {
            print("\n=========   Request httpBody   ========== \n" + "Found Request Body Nil")
        }
        
        if let responseData : Data = response.data {
            let responseString = String(data: responseData, encoding: String.Encoding.utf8)
            print("\n=========   Response Body   ========== \n" + responseString!)
            
        } else {
            print("\n=========   Response Body   ========== \n" + "Found Response Body Nil")
        }
        
        print("\n\n\n ✅ ✅ ✅  ------- Success Response End -------  ✅ ✅ ✅ \n\n\n")
        #endif
    }
    
    private func showRequestDetailForFailure(responseObject response : AFDataResponse<Data>) {
        #if DEBUG
        print("\n\n\n ❌ ❌ ❌ ❌ ❌ ------- Failure Response Start ------- ❌ ❌ ❌ ❌ ❌ \n")
        print(""+(response.request?.url?.absoluteString ?? ""))
        print("\n=========   allHTTPHeaderFields   ========== \n")
        print("%@",response.request!.allHTTPHeaderFields!)
        
        if let bodyData : Data = response.request?.httpBody {
            let bodyString = String(data: bodyData, encoding: String.Encoding.utf8)
            print("\n=========   Request httpBody   ========== \n" + bodyString!)
            
        } else {
            print("\n=========   Request httpBody   ========== \n" + "Found Request Body Nil")
        }
        
        if let responseData : Data = response.data {
            let responseString = String(data: responseData, encoding: String.Encoding.utf8)
            print("\n=========   Response Body   ========== \n" + responseString!)
            
        } else {
            print("\n=========   Response Body   ========== \n" + "Found Response Body Nil")
        }
        
        print("\n\n\n ❌ ❌ ❌ ------- Failure Response End ------- ❌ ❌ ❌ \n")
        #endif
    }
    
    private func successStatusMessage() -> ApiResponse {
        return ApiResponse(success: true, message: "", data: nil)
    }
    
    private func failureStatusMessage(_ message: String = "We are experiencing some technical difficulties and apologize for the inconvenience. Please try again later.") -> ApiResponse {
        return ApiResponse(success: false, message: message, data: nil)
    }
}
