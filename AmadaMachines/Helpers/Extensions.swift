//
//  Extensions.swift
//  AmadaMachines
//
//  Created by IT Support on 8/27/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

extension Date {
    func formatted(_ format: String = "dd/MM/yyyy HH:mm:ss a") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

extension UIViewController {

    public static var topMargin: CGFloat = 0

    func lowPowerModeON() -> Bool {
        return ProcessInfo.processInfo.isLowPowerModeEnabled
    }

}

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func loadImageUsingCacheWithUrlString(urlString: String) {
        self.image = nil
        // Check for cached image
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            // do something with the image
            print("Getting image from cache.")
            self.image = cachedImage
            return
        } else {
            print("Getting from internet.")
        }
        guard let url = URL(string: urlString) else {
            return
        }
        let data = try? Data(contentsOf: url)
        DispatchQueue.main.async {
            if let imageData = data {
                if let downloadedImage = UIImage(data: imageData) {
                    imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                    self.image = downloadedImage
                }
            }
        }
    }
}

extension UIColor {

    static func rgb(_ red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }

}

extension UIView {
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

/* UIColor extension */
extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }

    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }

    static var placeholder: UIColor {
        return UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22)
    }

    static var tableBackground: UIColor {
        return UIColor(netHex: 0xECECEC)
    }

    struct MainColors {
        static let red         = UIColor(netHex: 0xbd0000)
        static let green       = UIColor(netHex: 0x688b50)
        static let orange      = UIColor(netHex: 0xC58629)
        static let black       = UIColor(netHex: 0x130303)
        static let darkGray    = UIColor(netHex: 0x5C575A)
        static let lightGray   = UIColor(netHex: 0xDCDCDC)
        static let mainColor   = UIColor(netHex: 0x39729B)
        static let lightColor  = UIColor(netHex: 0x6EA4CA)
        static let darkColor   = UIColor(netHex: 0xE8E8E8)
        static let accentColor = UIColor(netHex: 0xD1E0EB)
        static let backgroundColor = UIColor(netHex: 0xE6ECF0)
    }
}

extension UIFont {
    struct MainFont {

    }
    struct LargeFont {
        static let light   = UIFont(name: "HelveticaNeue-Light", size: 35)
        static let Regular = UIFont(name: "HelveticaNeue-Medium", size: 35)
        static let Bold    = UIFont(name: "HelveticaNeue-Bold", size: 35)
    }

    struct MediumFont {
        static let light   = UIFont(name: "HelveticaNeue-Light", size: 25)
        static let Regular = UIFont(name: "HelveticaNeue-Medium", size: 25)
        static let Bold    = UIFont(name: "HelveticaNeue-Bold", size: 25)
    }

    struct SmallFont {
        static let light   = UIFont(name: "HelveticaNeue-Light", size: 16)
        static let Regular = UIFont(name: "HelveticaNeue-Medium", size: 16)
        static let Bold    = UIFont(name: "HelveticaNeue-Bold", size: 16)
    }
}

extension UIView {

    var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.topAnchor
        } else {
            return self.topAnchor
        }
    }

    var safeLeftAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *){
            return self.safeAreaLayoutGuide.leftAnchor
        }else {
            return self.leftAnchor
        }
    }

    var safeRightAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *){
            return self.safeAreaLayoutGuide.rightAnchor
        }else {
            return self.rightAnchor
        }
    }

    var safeBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.bottomAnchor
        } else {
            return self.bottomAnchor
        }
    }
}

extension UITextField {
    func setBottomLine(borderColor: UIColor) {
        self.borderStyle = UITextField.BorderStyle.none
        self.backgroundColor = UIColor.clear

        let borderLine = UIView()
        let height = 1.0
        borderLine.frame = CGRect(x: 0, y: Double(self.frame.height) - height, width: Double(self.frame.width), height: height)

        borderLine.backgroundColor = borderColor
        self.addSubview(borderLine)
    }

    func setLeftPadding(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }

    func setRightPadding(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

extension UITableView {

    func isLast(for indexPath: IndexPath) -> Bool {

        let indexOfLastSection = numberOfSections > 0 ? numberOfSections - 1 : 0
        let indexOfLastRowInLastSection = numberOfRows(inSection: indexOfLastSection) - 1

        return indexPath.section == indexOfLastSection && indexPath.row == indexOfLastRowInLastSection
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }

    func currencyFormatted() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        let formattedNumber = numberFormatter.string(from: NSNumber(value:self.rounded(toPlaces: 2)))
        return formattedNumber ?? ""
    }

    func formatted() -> String {
        return String(format: "%.2f", self)
    }
}

extension UIScrollView {
    func scrollToTop(_ animated: Bool = true) {
        let desiredOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(desiredOffset, animated: animated)
    }
}

extension UIView {
    var globalPoint: CGPoint? {
        return self.superview?.convert(self.frame.origin, to: nil)
    }

    var globalFrame: CGRect? {
        return self.superview?.convert(self.frame, to: nil)
    }
}

extension UIButton {

    func addShadow() {
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 10.0
        self.layer.masksToBounds = false
    }
}
