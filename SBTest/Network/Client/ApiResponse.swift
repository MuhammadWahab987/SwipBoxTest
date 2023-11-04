//
//  ApiResponse.swift
//  SBTest
//
//  Created by Muhammad Wahab on 02/11/2023.
//

import Foundation
import UIKit

class ApiResponse: NSObject {

    var success: Bool = false
    var message: String
    var data: AnyObject?
//    var responseCode: Int

    init(success: Bool, message: String?, data: AnyObject?) {
        self.success = success
        self.message = message ?? ""
        self.data = data
//        self.responseCode = responseCode
    }
}
