//
//  MovieDetailRequest.swift
//  SBTest
//
//  Created by Muhammad Wahab on 04/11/2023.
//

import Foundation

/// if you have any kind of parameters must use dependancy injection using initializer

class MovieDetailRequest: ApiRequest<MovieDetailModel> {
    
    var movieId = ""
    
    override func apiResource() -> String {
        return "movie/"
    }
    
    override func endPoint() -> String {
        return "\(movieId)"
    }
    
    override func requestType() -> HTTPMethod {
        return .get
    }
}
