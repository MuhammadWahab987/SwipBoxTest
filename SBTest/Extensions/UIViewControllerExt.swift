//
//  UIViewControllerExt.swift
//  CKTest
//
//  Created by Muhammad Wahab on 21/05/2023.
//

import Foundation
import UIKit

extension UIViewController {
    
    /**
     Add Custom back button on left side of navigation
     - parameter : none
     */
    
    func showNavigationBar()
    {
        self.navigationController?.navigationBar.isHidden = false
    }
    func hideNavigationBar()
    {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func addCustomBackButton(isWhiteBg:Bool) {
        let backButton: UIButton = UIButton (type: UIButton.ButtonType.custom)
        if isWhiteBg
        {
            backButton.setImage(#imageLiteral(resourceName: "WhiteBgBackIcon"), for: UIControl.State.normal)
        }
        else
        {
        backButton.setImage(#imageLiteral(resourceName: "BackIcon"), for: UIControl.State.normal)
        }
        backButton.addTarget(self, action: #selector(self.backButtonTapped(button:)), for: UIControl.Event.touchUpInside)
        backButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let barButton = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = barButton
    }
    func addCustomBackButton(image:UIImage) {
        let backButton: UIButton = UIButton (type: UIButton.ButtonType.custom)
        backButton.setImage(image, for: UIControl.State.normal)
        backButton.addTarget(self, action: #selector(self.backButtonTapped(button:)), for: UIControl.Event.touchUpInside)
        backButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let barButton = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = barButton
    }
    
    func addCustomBackButton(withLeftTitle title: String, isShowBackButton: Bool = true) {
        let backButton: UIButton = UIButton (type: UIButton.ButtonType.custom)
        backButton.setImage(#imageLiteral(resourceName: "BackIcon"), for: UIControl.State.normal)
        backButton.addTarget(self, action: #selector(self.backButtonTapped(button:)), for: UIControl.Event.touchUpInside)
        backButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let barButton = UIBarButtonItem(customView: backButton)
        
        let leftTitle: UIButton = UIButton (type: UIButton.ButtonType.custom)
        leftTitle.setTitle(title, for: .normal)
        leftTitle.setTitleColor(.white, for: .normal)
        leftTitle.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        backButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let leftTitleBarButton = UIBarButtonItem(customView: leftTitle)
        
        if isShowBackButton {
            self.navigationItem.leftBarButtonItems = [barButton, leftTitleBarButton]
            
        } else {
            self.navigationItem.leftBarButtonItems = [leftTitleBarButton]
        }
    }
    
    func addCustomBackButton(withLeftTitle title: String, and image: String) {
        let backButton: UIButton = UIButton (type: UIButton.ButtonType.custom)
        backButton.setImage(#imageLiteral(resourceName: "icon_back"), for: UIControl.State.normal)
        backButton.addTarget(self, action: #selector(self.backButtonTapped(button:)), for: UIControl.Event.touchUpInside)
        backButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let barButton = UIBarButtonItem(customView: backButton)
        
        let leftTitle: UIButton = UIButton (type: UIButton.ButtonType.custom)
        leftTitle.setTitle(title, for: .normal)
        leftTitle.setTitleColor(.black, for: .normal)
        leftTitle.titleLabel?.font = UIFont.systemFont(ofSize: 16)
//        backButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let leftTitleBarButton = UIBarButtonItem(customView: leftTitle)
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFill
        //imageView.circle()
        imageView.setImageFromUrl(path: image)
//        imageView.cahchedImage(path: image)
        let imageItem = UIBarButtonItem(customView: imageView)
        self.navigationItem.leftBarButtonItems = [barButton, imageItem, leftTitleBarButton]
    }
    
    @objc public func backButtonTapped(button: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func add(asChildViewController viewController: UIViewController, to containerView: UIView) {
        // Add Child View Controller
        addChild(viewController)

        // Add Child View as Subview
        containerView.addSubview(viewController.view)

        // Configure Child View
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        // Notify Child View Controller
        viewController.didMove(toParent: self)
    }
    
    func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParent: nil)

        // Remove Child View From Superview
        viewController.view.removeFromSuperview()

        // Notify Child View Controller
        viewController.removeFromParent()
    }
    
    func topMostViewController() -> UIViewController {
        
        
        if let navigation = self as? UINavigationController {
            return navigation.visibleViewController!.topMostViewController()
        }
        
        if let tab = self as? UITabBarController {
            if let selectedTab = tab.selectedViewController {
                return selectedTab.topMostViewController()
            }
            return tab.topMostViewController()
        }
        
        if self.presentedViewController == nil {
            return self
        }
        
        if let navigation = self.presentedViewController as? UINavigationController {
            return navigation.visibleViewController!.topMostViewController()
        }
        
        if let tab = self.presentedViewController as? UITabBarController {
            
            if let selectedTab = tab.selectedViewController {
                return selectedTab.topMostViewController()
            }
            
            return tab.topMostViewController()
        }
        
        return self.presentedViewController!.topMostViewController()
    }
}
