//
//  Extensions.swift
//  123
//
//  Created by gdml on 06/05/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func format() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd"
        let finish = dateFormatterPrint.string(from: Date())
        return finish
    }
    
}
extension Int {
    
    func convertToCelsius() -> Int {
        return abs(Int(self - 32) * Int(5.0) / Int(9.0))
    }
    
}

extension UIImage {
    
    func imageResize (sizeChange:CGSize)-> UIImage {
        
        let hasAlpha = true
        let scale: CGFloat = 0.0 // Use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        self.draw(in: CGRect(origin: CGPoint.zero, size: sizeChange))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage!
    }
    
}

extension UIColor {
    convenience init(hexFromString:String, alpha:CGFloat = 1.0) {
        var cString:String = hexFromString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        var rgbValue:UInt64 = 10066329 //color #999999 if string has wrong format

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) == 6) {
            Scanner(string: cString).scanHexInt64(&rgbValue)
        }

        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}
extension UINavigationController {
    
func switchController(vc: UIViewController, duration: CFTimeInterval, type: CATransitionSubtype) {
    let customVcTransition = vc
    let transition = CATransition()
    transition.duration = duration
    transition.type = CATransitionType.push
    transition.subtype = type
    transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    view.window!.layer.add(transition, forKey: kCATransition)
    present(customVcTransition, animated: false, completion: nil)
}}
