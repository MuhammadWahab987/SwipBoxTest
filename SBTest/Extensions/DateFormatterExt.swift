//
//  DateFormatterExt.swift
//  CKTest
//
//  Created by Muhammad Wahab on 21/05/2023.
//

import Foundation

extension DateFormatter {
    
    static let MMMDYYYY = dateFormatter(format: "MMM d, yyyy")
    static let ddMMMyyyy = dateFormatter(format: "dd-MMM-yyyy")
    // API date formatter
    static let mmddyyyyTime12Hours = dateFormatter(format: "MM/dd/yyyy hh:mm a")
    
    static let hmma = dateFormatter(format: "hh:mm a")
    
    static let ddmmyyTime12Hours: DateFormatter = {
        let formatter = mmddyyyyTime12Hours
        formatter.calendar = Calendar(identifier: .iso8601)
        return formatter
    }()
    
    private static func dateFormatter(format: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.changeFormate(isTweleveHours: true)
        return formatter
    }
    
    func changeFormate(isTweleveHours:Bool = true) {
        
        if (isTweleveHours) {
            let twelveHourLocale = Locale(identifier: "en_US_POSIX")
            self.locale = twelveHourLocale
            
        } else {
            let twelveHourLocale = Locale(identifier: "en_GB")
            self.locale = twelveHourLocale
        }
    }
}

extension Optional where Wrapped == Int {

    var orZero: Int {
        return self ?? 0
    }
    
    func boolValue() -> Bool {
        return self == 1 ? true : false
    }
}
