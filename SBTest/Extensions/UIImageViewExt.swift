//
//  UIImageViewExt.swift
//  CKTest
//
//  Created by Muhammad Wahab on 21/05/2023.
//

import Foundation
import UIKit
import AlamofireImage

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func setupActivityIndicator() {
        
        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: (frame.size.width/2) - 15, y: (frame.size.height/2) - 15, width: 30, height: 30))
        activityIndicator.tag = 6565
        activityIndicator.startAnimating()
        self.addSubview(activityIndicator)
        self.bringSubviewToFront(activityIndicator)
    }
    func stopActivityIndicator() {
        if let activityInficator = self.viewWithTag(6565) {
            activityInficator.removeFromSuperview()
        }
    }
    
    /// A function that downloads the image from the given url
    /// - Parameter path: url string of the image
    
    func setImageFromUrl(path: String, size:String = "300X300", isSecureImage: Bool = true) {
        let compressedPath = path.replacingOccurrences(of: "1000X1000", with: size)
        guard let imageUrl = URL(string: isSecureImage ? compressedPath : compressedPath ) else { return }
        image = nil
       
        // retriving image from cache
        if let imageFromCache = imageCache.object(forKey: path as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        // setup activityIndicator...
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = .darkGray
        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        activityIndicator.startAnimating()
        
        // image does not available in cache.. so retrieving it from url...
        URLSession.shared.dataTask(with: imageUrl, completionHandler: { (data, response, error) in
            
            if error != nil {
                print(error as Any)
                DispatchQueue.main.async {
                    activityIndicator.stopAnimating()
                    self.image = UIImage(color: .lightGray)
                }
                return
            }
            
            DispatchQueue.main.async {
                
                if let unwrappedData = data, let imageToCache = UIImage(data: unwrappedData) {
                    let data = imageToCache.jpeg(.low)
                    let completeImage = UIImage(data: data ?? unwrappedData) ?? imageToCache
                    self.image = completeImage
                    imageCache.setObject(completeImage, forKey: path as AnyObject)
                    
                } else { self.image = UIImage(color: .lightGray) }
                activityIndicator.stopAnimating()
            }
        }).resume()
    }
    
    func setImageWithAlomofire(withUrl url: URL, andPlaceholder placeholder: UIImage?) {
        self.layoutIfNeeded()
        self.setupActivityIndicator()
        let filter = self.frame.size.width == 0 || self.frame.size.height == 0 ? nil : RoundedCornersFilter(radius: 6.0)
        
        self.af_setImage(withURL: url, placeholderImage: nil, filter: filter, progress: nil, progressQueue: DispatchQueue.main, imageTransition: ImageTransition.crossDissolve(0.5), runImageTransitionIfCached: false) { (image) in
            self.stopActivityIndicator()
        }
    }
}
