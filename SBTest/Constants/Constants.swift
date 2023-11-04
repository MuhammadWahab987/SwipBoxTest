
//
//  Constants.swift
//  SBTest
//
//  Created by Muhammad Wahab on 02/11/2023.
//

import Foundation



class Constant: NSObject {
    
    // MARK: - Network & Third party
    static var baseUrl = "https://api.themoviedb.org/3/"
    static var authToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5YmI1YjYzMzNhODdkMGE0OWYwMTUzMGE5NWQ4ZTEwNCIsInN1YiI6IjY1NDM3NGQxNmJlYWVhMDBhYzFlOWEyZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.SfOQsCzQUWkIK564znHO5iwXjoCC3NxlvdY2vuUhlK8"
    
    static var imagesBaseUrl = "https://image.tmdb.org/t/p/original"
    
    
    struct userDefaults
    {
        static let MovieListing = "MovieListing"
    }
}


enum VTMessageType: Int {
    case error = 0
    case success
    case info
}

enum MessageType: Int {
    case image = 2
    case text = 1
}
