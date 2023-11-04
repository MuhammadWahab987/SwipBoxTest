//
//  UIDeviceExt.swift
//  CKTest
//
//  Created by Muhammad Wahab on 21/05/2023.
//

import Foundation
import UIKit

extension UIDevice {
    
    static var isIpad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    static var hasTopNotch: Bool {
        let window = ApplicationSetup.window
        let bottom = window?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
    
}

class ApplicationSetup {
 
    
    // MARK: Private Methods
    
    static private (set) var sceneDelegate: SceneDelegate? {
        get {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let sceneDelegate = windowScene.delegate as? SceneDelegate else { return nil }
            return sceneDelegate
        }
        
        set {}
    }
    
    static var window: UIWindow? {
        get {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let sceneDelegate = windowScene.delegate as? SceneDelegate else { return nil }
            return sceneDelegate.window
        }
    }
    
    class func setupLibraries() {
    //    IQKeyboardManager.shared.enable = true
    }
    
    
    
}
