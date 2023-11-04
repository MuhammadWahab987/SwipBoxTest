//
//  BaseViewController.swift
//  SBTest
//
//  Created by Muhammad Wahab on 02/11/2023.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {

//    var activityView = UIActivityIndicatorView(style: .large)
    open var baseViewModel: BaseViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func setupViewController() {
        
    }
    
    func setupNavigationBarUI() {
        
    }
   
    //MARK:- Alert View Methods
    
    //This method is going to be used for alert view
    func showAlertView(message: String) {
        
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func showAlertWithCompletionHandler(message: String, completion: @escaping () -> ()) {
        
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)

        let defaultAction = UIAlertAction(title: "OK", style: .default) { (action) in
            DispatchQueue.main.async {
                completion()
            }
        }
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    func showToast(message:String)
    {
        self.view.makeToast(message)
    }
}

extension BaseViewController: BaseViewModelDelegate {

    func showErrorAlert(message: String) {
//        AlertBuilder.failureAlertWithMessage(message: message)
    }

    func showSuccessAlert(message: String) {
//        AlertBuilder.successAlertWithMessage(message: message)
    }

    func showPorgress() {
        DispatchQueue.main.async {
            Loader.showLoading()
        }
        
    }

    func hideProgress() {
        DispatchQueue.main.async {
            Loader.hideLoading()
        }
            
    }
}
