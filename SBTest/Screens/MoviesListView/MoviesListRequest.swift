//
//  MoviesListRequest.swift
//  SBTest
//
//  Created by Muhammad Wahab on 02/11/2023.
//

import Foundation

/// if you have any kind of parameters must use dependancy injection using initializer

class MoviesListRequest: ApiRequest<MoviesListModel> {
    
    override func apiResource() -> String {
        return "movie/"
    }
    
    override func endPoint() -> String {
        return "popular"
    }
    
    override func requestType() -> HTTPMethod {
        return .get
    }
}
