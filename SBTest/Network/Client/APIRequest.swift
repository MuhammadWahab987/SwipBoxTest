//
//  APIRequest.swift
//  SBTest
//
//  Created by Muhammad Wahab on 02/11/2023.
//

import Foundation
import Alamofire

public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

class ApiRequest<ResponseType: Codable> {

    func serviceUrl() -> String {
        return Constant.baseUrl
    }

    func apiPath() -> String {
        return ""
    }

    func apiVersion() -> String {
        return ""
    }
    
    func apiLanguage() -> String {
        return ""
    }

    func apiResource() -> String {
        return ""
    }

    func endPoint() -> String {
        return ""
    }

    func parameters() -> NSDictionary? {
        return [:]
    }

    func arrayParameters() -> NSArray? {
        return nil
    }

    func multiPartParameters() -> (MultipartFormData) -> Void {
        return { (multipartFormData) in

        }
    }

    func requestType() -> HTTPMethod {
        return .post
    }
    
    func baseResponseKey() -> String {
        return "data"
    }

    func responseKey() -> String? {
        return nil
    }
}
