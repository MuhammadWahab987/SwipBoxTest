//
//  UIImageExt.swift
//  CKTest
//
//  Created by Muhammad Wahab on 21/05/2023.
//

import Foundation
import UIKit

public extension UIImage {

    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }

    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }

    var png: Data? { return self.pngData() }
    
    func jpeg(_ quality: JPEGQuality) -> Data? {
        return self.jpegData(compressionQuality: quality.rawValue)
    }
    
    
    class func ProfileImage() -> UIImage {
        return UIImage(named: "ProfileImage") ?? UIImage()
    }
    class func BackIcon() -> UIImage {
        return UIImage(named: "BackIcon") ?? UIImage()
    }

}
