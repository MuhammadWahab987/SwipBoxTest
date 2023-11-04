//
//  Loader.swift
//  SBTest
//
//  Created by Muhammad Wahab on 02/11/2023.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class Loader: NSObject {
    
    class func showLoading(offSet: CGFloat = 0) {
        hideLoading()
        let superView = UIView(frame: CGRect(x: 0, y: 0 - offSet, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        let activityIndicator = NVActivityIndicatorView(frame: CGRect(x: superView.frame.width/2 - 45, y: superView.frame.height/2 - 42, width: 90, height: 90))
        let iconImageView = UIImageView(frame: CGRect(x: superView.frame.width/2 - 32.5, y: superView.frame.height/2 - 20, width: 60, height: 40))
        
        iconImageView.image = #imageLiteral(resourceName: "SwipBoxLogo")
        superView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        iconImageView.clipsToBounds = true
        //iconImageView.layer.cornerRadius = iconImageView.frame.height/2
        superView.tag = 9000
        activityIndicator.type = .circleStrokeSpin
        activityIndicator.color = .white
        activityIndicator.startAnimating()
        superView.addSubview(iconImageView)
        superView.addSubview(activityIndicator)
        superView.bringSubviewToFront(activityIndicator)
        superView.bringSubviewToFront(iconImageView)
        ApplicationSetup.window?.addSubview(superView)
    }
    
    class func hideLoading() {
        
        if let activityView = ApplicationSetup.window?.viewWithTag(9000) {
            activityView.removeFromSuperview()
        }
    }
    
    class func showListLoading(viewController: UIViewController, topPadding: CGFloat = 15) {
        let activityIndicator = NVActivityIndicatorView(frame: CGRect(x: UIScreen.main.bounds.width/2 - 15, y: topPadding, width: 30, height: 30))
        activityIndicator.type = .ballClipRotate
        activityIndicator.color = UIColor.green
        activityIndicator.tag = 9001
        activityIndicator.startAnimating()
        viewController.view.addSubview(activityIndicator)
        viewController.view.bringSubviewToFront(activityIndicator)
        viewController.view.setNeedsLayout()
        viewController.view.setNeedsDisplay()
    }
    
    func hideListLoading(viewController: UIViewController?) {
        if let activityView = viewController?.view.viewWithTag(9001) {
            activityView.removeFromSuperview()
        }
    }
}
