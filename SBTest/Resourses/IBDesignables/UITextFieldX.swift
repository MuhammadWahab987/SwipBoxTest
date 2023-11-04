//
//  DesignableUITextField.swift
//  SkyApp
//
//  Created by Mark Moeykens on 12/16/16.
//  Copyright © 2016 Mark Moeykens. All rights reserved.
//

import UIKit

@IBDesignable
class UITextFieldX: UITextField {
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var leftPadding: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var rightImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var rightPadding: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var placeHolderColor: UIColor? {
          get {
              return self.placeHolderColor
          }
          set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
          }
      }
    
    
    @IBInspectable var insetX: CGFloat = 6 {
       didSet {
         layoutIfNeeded()
       }
    }
    @IBInspectable var insetY: CGFloat = 6 {
       didSet {
         layoutIfNeeded()
       }
    }

    // placeholder position
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        
        if self.tag == 2233
        {
            return bounds.inset(by: UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: 30))
        }
        else
        {
        return bounds.insetBy(dx: insetX , dy: insetY)
        }
        
    }

    // text position
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX , dy: insetY)
    }
    
    @IBInspectable open var characterSpacing:CGFloat = 1.0 {
        didSet {
            let attributedString = NSMutableAttributedString(string: self.text!)
         attributedString.addAttribute(NSAttributedString.Key.kern, value: self.characterSpacing, range: NSRange(location: 0, length: attributedString.length))
            self.attributedText = attributedString
        }

    }
//    @IBInspectable public var underLineWidth: CGFloat = 0.0 {
//            didSet {
//                updateUnderLineFrame()
//            }
//        }
//
//        /// Sets the underline color
//        @IBInspectable public var underLineColor: UIColor = .groupTableViewBackground {
//            didSet {
//                updateUnderLineUI()
//            }
//        }
//
//    // MARK: - Underline
//        private var underLineLayer = CALayer()
//        private func applyUnderLine() {
//            // Apply underline only if the text view's has no borders
//            if borderStyle == UITextField.BorderStyle.none {
//                underLineLayer.removeFromSuperlayer()
//                updateUnderLineFrame()
//                updateUnderLineUI()
//                layer.addSublayer(underLineLayer)
//                layer.masksToBounds = true
//            }
//        }
//
//        private func updateUnderLineFrame() {
//            var rect = bounds
//            rect.origin.y = bounds.height - underLineWidth
//            rect.size.height = underLineWidth
//            underLineLayer.frame = rect
//        }
//
//        private func updateUnderLineUI() {
//            underLineLayer.backgroundColor = underLineColor.cgColor
//        }
    
    
    
    private var _isRightViewVisible: Bool = true
    var isRightViewVisible: Bool {
        get {
            return _isRightViewVisible
        }
        set {
            _isRightViewVisible = newValue
            updateView()
        }
    }
    
    func updateView() {
        setLeftImage()
        setRightImage()
        
//        // Placeholder text color
//        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedStringKey.foregroundColor: tintColor])
    }
    
    func setLeftImage() {
        leftViewMode = UITextField.ViewMode.always
        var view: UIView
        
        if let image = leftImage {
            let imageView = UIImageView(frame: CGRect(x: leftPadding, y: 0, width: 20, height: 20))
            imageView.image = image
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            imageView.tintColor = tintColor
            
            var width = imageView.frame.width + leftPadding
            
            if borderStyle == UITextField.BorderStyle.none || borderStyle == UITextField.BorderStyle.line {
                width += 5
            }
            
            view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20))
            view.addSubview(imageView)
        } else {
            view = UIView(frame: CGRect(x: 0, y: 0, width: leftPadding, height: 20))
        }
        
        leftView = view
    }
    
    func setRightImage() {
        rightViewMode = UITextField.ViewMode.always
        
        var view: UIView
        
        if let image = rightImage, isRightViewVisible {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.image = image
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            imageView.tintColor = tintColor
            
            var width = imageView.frame.width + rightPadding
            
            if borderStyle == UITextField.BorderStyle.none || borderStyle == UITextField.BorderStyle.line {
                width += 5
            }
            
            view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20))
            view.addSubview(imageView)
            
        } else {
            view = UIView(frame: CGRect(x: 0, y: 0, width: rightPadding, height: 20))
        }
        
        rightView = view
    }
    
    
    // MARK: - Corner Radius
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    // MARK: - Shadow
    @IBInspectable var shadowOffset: CGSize{
          get{
              return self.layer.shadowOffset
          }
          set{
              self.layer.shadowOffset = newValue
          }
      }

      @IBInspectable var shadowColor: UIColor{
          get{
              return UIColor(cgColor: self.layer.shadowColor!)
          }
          set{
              self.layer.shadowColor = newValue.cgColor
          }
      }

      @IBInspectable var shadowRadius: CGFloat{
          get{
              return self.layer.shadowRadius
          }
          set{
              self.layer.shadowRadius = newValue
          }
      }

      @IBInspectable var shadowOpacity: Float{
          get{
              return self.layer.shadowOpacity
          }
          set{
              self.layer.shadowOpacity = newValue
          }
      }
}
