//
//  NSObjectExt.swift
//  CKTest
//
//  Created by Muhammad Wahab on 21/05/2023.
//

import Foundation


extension NSObject {
    static func className() -> String {
        return String(describing: self)
    }
}
