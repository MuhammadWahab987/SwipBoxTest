//
//  UserDefaultsHelper.swift
//  satoriNativeIos
//
//  Created by User on 12/28/21.
//

import Foundation
import UIKit

class UserDefaultsHelper: NSObject {
    
    
    //MARK: - MOVIE LISTING
    func saveMovieListing(movieList: MoviesListModel?) {
        
        if movieList == nil {
            
            let defaults = UserDefaults.standard
            defaults.removeObject(forKey: Constant.userDefaults.MovieListing)
        } else {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(movieList!) {
                let defaults = UserDefaults.standard
                defaults.set(encoded, forKey: Constant.userDefaults.MovieListing)
                defaults.synchronize()
            }
            
        }
    }
    func getMovieListing() -> MoviesListModel? {
        
        if let savedValue = UserDefaults.standard.value(forKey: Constant.userDefaults.MovieListing) as? Data {
            //return savedValue
            let decoder = JSONDecoder()
            if let movieList = try? decoder.decode(MoviesListModel.self, from: savedValue) {
                return movieList
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    
    
    
    //MARK: - MOVIE
    func saveMovie(movieId:String, movie: MovieDetailModel?) {
        
        if movie == nil {
            
            let defaults = UserDefaults.standard
            defaults.removeObject(forKey: movieId)
        } else {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(movie!) {
                let defaults = UserDefaults.standard
                defaults.set(encoded, forKey: movieId)
                defaults.synchronize()
            }
            
        }
    }
    func getMovie(movieId:String) -> MovieDetailModel? {
        
        if let savedValue = UserDefaults.standard.value(forKey: movieId) as? Data {
            //return savedValue
            let decoder = JSONDecoder()
            if let movie = try? decoder.decode(MovieDetailModel.self, from: savedValue) {
                return movie
            } else {
                return nil
            }
        } else {
            return nil
        }
    }

    
    func removeUserDefaultWithKey(key:String){
        
        UserDefaults.standard.removeObject(forKey: key)
    }
    func removeAllUserDefaults()
    {
        
    }
}

