//
//  UserDefaultsHelper.swift
//  satoriNativeIos
//
//  Created by User on 12/28/21.
//

import Foundation
import UIKit

class UserDefaultsHelper: NSObject {
    
    
    //MARK: - Login Token
    /*func saveLoginToken(token: String?) {
        
        if token == nil {
            
            let defaults = UserDefaults.standard
            defaults.removeObject(forKey: GlobalKeys.userDefaults.loginToken)
        } else {
            
            let defaults = UserDefaults.standard
            defaults.set(token, forKey: GlobalKeys.userDefaults.loginToken)
            defaults.synchronize()
        }
    }
    func getLoginToken() -> String? {
        
        if let instructions = UserDefaults.standard.value(forKey: GlobalKeys.userDefaults.loginToken) as? String {
            return instructions
        } else {
            return nil
        }
    }*/
    
    //MARK: - JsonStringOfReportManager
    /*func saveJsonStringOfReportManager(jsonString: String?) {
        
        if jsonString == nil {
            
            let defaults = UserDefaults.standard
            defaults.removeObject(forKey: GlobalKeys.userDefaults.JsonStringOfReportManager)
        } else {
            
            let defaults = UserDefaults.standard
            defaults.set(jsonString, forKey: GlobalKeys.userDefaults.JsonStringOfReportManager)
            defaults.synchronize()
        }
    }
    func getJsonStringOfReportManager() -> String? {
        
        if let jsonString = UserDefaults.standard.value(forKey: GlobalKeys.userDefaults.JsonStringOfReportManager) as? String {
            return jsonString
        } else {
            return nil
        }
    }*/
    
    //MARK: - SelectedProject
   /* func saveSelectedProject(project: DatumGetProjects?) {
        
        if project == nil {
            
            let defaults = UserDefaults.standard
            defaults.removeObject(forKey: GlobalKeys.userDefaults.SelectedProject)
        } else {
            
            /*let defaults = UserDefaults.standard
             defaults.set(project, forKey: GlobalKeys.userDefaults.SelectedProject)
             defaults.synchronize()*/
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(project!) {
                let defaults = UserDefaults.standard
                defaults.set(encoded, forKey: GlobalKeys.userDefaults.SelectedProject)
                defaults.synchronize()
            }
            
        }
    }
    func getSelectedProject() -> DatumGetProjects? {
        
        if let savedValue = UserDefaults.standard.value(forKey: GlobalKeys.userDefaults.SelectedProject) as? Data {
            //return savedValue
            let decoder = JSONDecoder()
            if let project = try? decoder.decode(DatumGetProjects.self, from: savedValue) {
                return project
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    */
    
    
    
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

