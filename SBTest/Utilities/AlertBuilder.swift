//
//  AlertBuilder.swift
//  SBTest
//
//  Created by Muhammad Wahab on 02/11/2023.
//


import Foundation
import UIKit
import UserNotifications

typealias ConfirmHandler = () -> Void
typealias CancelHandler = () -> Void

class AlertBuilder: NSObject {

    /// A function that presents an alert on the current screen
    /// - Parameter message: Message to be displayed in the alert
    public static func successAlertWithMessage(message: String?) {
        self.alertWithTitle(title: "Success", message: message, cancelButtonShow: false, confirmHandler: nil)
    }

    /// A function that presents an alert on the current screen
    /// - Parameter message: Message to be displayed in the alert
    public static func failureAlertWithMessage(message: String?) {
        self.alertWithTitle(title: "Error", message: message, cancelButtonShow: false, confirmHandler: nil)
    }

    /// A function that presents an alert on the current screen with custom actions
    /// - Parameters:
    ///   - title: Title for the alert
    ///   - message: Message to be displayed in the alert
    ///   - cancelButtonShow: A bool that represents that weather we want to show cancel button or not
    ///   - confirmHandler: Completion block called when user taps on okay
    public static func alertWithTitle(title: String?, message: String?, cancelButtonShow: Bool, confirmHandler: ConfirmHandler?) {
        let alert = prepareAlert(title: title, message: message)
        addAction(alert: alert, title: "Okay", style: .default, handler: confirmHandler)

        if(cancelButtonShow) {
            addAction(alert: alert, title: "Cancel", style: .cancel)
        }
        showAlert(alert: alert)
    }

    static func prepareAlert(title: String?, message: String?) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        return alertController
    }

    private static func showAlert(alert: UIAlertController) {
        DispatchQueue.main.async {
            self.topMostController().present(alert, animated: true, completion: nil)
        }
    }
    
    public static func showBannerBelowNavigation(message: String, type: VTMessageType = .error, topConstraint: CGFloat = 20.0) {
        var viewHeight: CGFloat = 40

        if message.count > 55 {
            viewHeight = 60
        }
        
        let viewController = topMostController()

        let errorView = UIView(frame: CGRect(x: 0, y: UIDevice.hasTopNotch ? (44 + topConstraint) : topConstraint, width: UIScreen.main.bounds.width, height: viewHeight))
        let errorLabel = UILabel(frame: CGRect(x: errorView.frame.origin.x + 10, y: 0.0, width: errorView.frame.width-10, height: errorView.frame.height))

        errorView.backgroundColor = UIColor.red.withAlphaComponent(0.8)

        errorLabel.text = message
        errorLabel.textAlignment = .center
        errorLabel.textColor = UIColor.white
        errorLabel.font = UIFont.systemFont(ofSize: 14)
        errorLabel.numberOfLines = 0

        if type == .success {
            errorView.backgroundColor = .green
            errorLabel.font = UIFont.systemFont(ofSize: 14)

        } else if type == .info {
            errorView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        }

        errorView.addSubview(errorLabel)
        viewController.view.addSubview(errorView)
        viewController.view.bringSubviewToFront(errorView)

        let when = DispatchTime.now() + 2 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {

            errorView.alpha = 1.0
            
            
            UIView.animate(withDuration: 2.0, animations: {
                errorView.alpha = 0.0
                
            }, completion: { (completed) in
                errorView.removeFromSuperview()
            })
        }
    }

    /// A function that gets currently visible view controller from the UIApplication Window
    /// - Returns: Returns the top most viewController in the current window
    static func topMostController() -> UIViewController {
        var topController: UIViewController? = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController
        while ((topController?.presentedViewController) != nil) {
            topController = topController?.presentedViewController
        }
        return topController!
    }

    static func addAction(alert: UIAlertController, title: String?, style: UIAlertAction.Style, handler: ConfirmHandler? = nil) {
        alert.addAction(UIAlertAction(title: title, style: style, handler: { _ in
            if(handler != nil) {
                handler!()
            }
        }))
    }
    
    public static func showInAppNotification(title: String, message: String, identifier: String, userInfo: [AnyHashable: Any] = [:]) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = message
        content.sound = UNNotificationSound.default
        content.userInfo = userInfo
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.5, repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: notificationTrigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    public static func showServerUrlDialog() {
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Add your local server url or cancel to go with default", message: "Enter a url", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.text = "http://"
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            Constant.baseUrl = textField?.text ?? Constant.baseUrl
            Constant.baseUrl = textField?.text ?? Constant.baseUrl
            print("Text field: \(textField?.text ?? "")")
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { [weak alert] (_) in
            alert?.dismiss(animated: true, completion: nil)
        }))
        
        // 4. Present the alert.
        AlertBuilder.topMostController().present(alert, animated: true, completion: nil)
    }
    
    
    public static func showBannerForInactiveAccount(message: String, type: VTMessageType = .success, topConstraint: CGFloat = 20.0) {
        var viewHeight: CGFloat = 40

        if message.count > 55 {
            viewHeight = 60
        }
        
        let viewController = topMostController()

        let errorView = UIView(frame: CGRect(x: 0, y: UIDevice.hasTopNotch ? (44 + topConstraint) : topConstraint, width: UIScreen.main.bounds.width, height: viewHeight))
        let errorLabel = UILabel(frame: CGRect(x: errorView.frame.origin.x + 10, y: 0.0, width: errorView.frame.width-10, height: errorView.frame.height))

        errorView.backgroundColor = UIColor.red.withAlphaComponent(0.8)

        errorLabel.text = message
        errorLabel.textAlignment = .center
        errorLabel.textColor = UIColor.white
        errorLabel.font = UIFont.systemFont(ofSize: 13)
        errorLabel.numberOfLines = 0

        if type == .success {
            errorView.backgroundColor = UIColor.green
            errorLabel.font = UIFont.systemFont(ofSize: 14)

        } else if type == .info {
            errorView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        }

        errorView.addSubview(errorLabel)
        viewController.view.addSubview(errorView)
        viewController.view.bringSubviewToFront(errorView)

        let when = DispatchTime.now() + 1 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {

            errorView.alpha = 1.0
            
            
//            UIView.animate(withDuration: 2.0, animations: {
//                errorView.alpha = 0.0
//
//            }, completion: { (completed) in
//                errorView.removeFromSuperview()
//            })
        }
    }

    
}


