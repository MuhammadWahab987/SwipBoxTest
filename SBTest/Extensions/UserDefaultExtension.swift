//
//  UserDefaultExtension.swift
//  satoriNativeIos
//
//  Created by User on 12/28/21.
//

import Foundation

extension UserDefaults
{
    
    static func isExists(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
}
