//
//  BaseViewModel.swift
//  SBTest
//
//  Created by Muhammad Wahab on 02/11/2023.
//

import Foundation
import UIKit

@objc protocol BaseViewModelDelegate: AnyObject {
    func showErrorAlert(message: String)
    func showSuccessAlert(message: String)
    func showPorgress()
    func hideProgress()
}

public class BaseViewModel {
    weak var baseDelegate: BaseViewModelDelegate?
    
    
    // MARK: - Socket Delegate
    
    @objc func didFireSocketNotification(notification: Notification) {
        
    }

}
