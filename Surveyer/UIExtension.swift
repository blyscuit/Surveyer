//
//  UIExtension.swift
//  Surveyer
//
//  Created by Pisit W on 10/6/2563 BE.
//  Copyright © 2563 blyscuit. All rights reserved.
//

import UIKit


extension UIColor {
    
    convenience init(hex:Int, alpha:CGFloat = 1.0) {
        self.init(
            red:   CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8)  / 255.0,
            blue:  CGFloat((hex & 0x0000FF) >> 0)  / 255.0,
            alpha: alpha
        )
    }
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}


extension UIFont {
    enum Noto: String {
        case FontNotoSansRegular = "NotoSans-Regular"
        , FontNotoSansBold = "NotoSans-Bold"
    }
    
    class func NotoOf(weight: Noto, ofSize: CGFloat) -> UIFont {
        return UIFont(name: weight.rawValue, size: ofSize * fontScale(for: ofSize)) ?? UIFont.systemFont(ofSize: ofSize * fontScale(for: ofSize))
    }
    
    static var Header_NotoBold_28 = NotoOf(weight: .FontNotoSansBold, ofSize: 28)
    static var Title_NotoBold_20 = NotoOf(weight: .FontNotoSansBold, ofSize: 20)
    static var Title_NotoBold_24 = NotoOf(weight: .FontNotoSansBold, ofSize: 24)
    static var Button_NotoBold_16 = NotoOf(weight: .FontNotoSansBold, ofSize: 16)
    static var Button_NotoBold_14 = NotoOf(weight: .FontNotoSansBold, ofSize: 14)
    static var Body_NotoRegular_16 = NotoOf(weight: .FontNotoSansRegular, ofSize: 16)
    static var Body2_NotoRegular_14 = NotoOf(weight: .FontNotoSansRegular, ofSize: 14)
    static var Caption_NotoRegular_12 = NotoOf(weight: .FontNotoSansRegular, ofSize: 12)
    
}

public func fontScale(for fontSize: CGFloat) -> CGFloat {
    switch UIApplication.shared.preferredContentSizeCategory {
    case UIContentSizeCategory.accessibilityExtraExtraExtraLarge:    return (fontSize + 8) / fontSize
    case UIContentSizeCategory.accessibilityExtraExtraLarge:         return (fontSize + 7) / fontSize
    case UIContentSizeCategory.accessibilityExtraLarge:              return (fontSize + 6) / fontSize
    case UIContentSizeCategory.accessibilityLarge:                   return (fontSize + 5) / fontSize
    case UIContentSizeCategory.accessibilityMedium:                  return (fontSize + 4) / fontSize
    case UIContentSizeCategory.extraExtraExtraLarge:                 return (fontSize + 3) / fontSize
    case UIContentSizeCategory.extraExtraLarge:                      return (fontSize + 2) / fontSize
    case UIContentSizeCategory.extraLarge:                           return (fontSize + 1) / fontSize
    case UIContentSizeCategory.large:                                return 1.0
    case UIContentSizeCategory.medium:                               return (fontSize - 1) / fontSize
    case UIContentSizeCategory.small:                                return (fontSize - 2) / fontSize
    case UIContentSizeCategory.extraSmall:                           return (fontSize - 3) / fontSize
    default:
        return 1.0
    }
}


public func viewScale(for fontSize: CGFloat) -> CGFloat {
    let viewSize = fontSize / 5.0
    switch UIApplication.shared.preferredContentSizeCategory {
    case UIContentSizeCategory.accessibilityExtraExtraExtraLarge:    return (viewSize + 8) / viewSize
    case UIContentSizeCategory.accessibilityExtraExtraLarge:         return (viewSize + 7) / viewSize
    case UIContentSizeCategory.accessibilityExtraLarge:              return (viewSize + 6) / viewSize
    case UIContentSizeCategory.accessibilityLarge:                   return (viewSize + 5) / viewSize
    case UIContentSizeCategory.accessibilityMedium:                  return (viewSize + 4) / viewSize
    case UIContentSizeCategory.extraExtraExtraLarge:                 return (viewSize + 3) / viewSize
    case UIContentSizeCategory.extraExtraLarge:                      return (viewSize + 2) / viewSize
    case UIContentSizeCategory.extraLarge:                           return (viewSize + 1) / viewSize
    case UIContentSizeCategory.large:                                return 1.0
    case UIContentSizeCategory.medium:                               return (viewSize - 1) / viewSize
    case UIContentSizeCategory.small:                                return (viewSize - 2) / viewSize
    case UIContentSizeCategory.extraSmall:                           return (viewSize - 3) / viewSize
    default:
        return 1.0
    }
}


extension UIView {
    
    @IBInspectable
    var _cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            //            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            let color = UIColor.init(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = CGSize(width: 0, height: 5)
            layer.shadowRadius = newValue
            clipsToBounds = false
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = CGSize(width: 0, height: 5)
            layer.shadowOpacity = newValue
        }
    }
    
    func addDropShadow(color: UIColor = UIColor.black, opacity: Float = 0.1, offSetX: Double, offSetY: Double, radius: CGFloat = 8) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = CGSize(width: offSetX, height: offSetY)
        layer.shadowRadius = radius
    }
    
    func removeShadow() {
        layer.shadowOpacity = 0
    }
}
