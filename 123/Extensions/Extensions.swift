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
    
    static func now(timeOffset: Int) -> Int {
    let time = timeOffset * 3600
    let date = Date()
    var calendar = Calendar.current
    calendar.timeZone = TimeZone(secondsFromGMT: time)!
    let hour = calendar.component(.hour, from: date)
    let minute = calendar.component(.minute, from: date)
    return (hour * 60) + minute
    }
    
    func convertToHours(time: Int) -> Int {
        let date = NSDate(timeIntervalSince1970: TimeInterval(self))
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: time * 3600)!
        let hour = calendar.component(.hour, from: date as Date)
        let minute = calendar.component(.minute, from: date as Date)
        return (hour * 60) + minute
    }
    
    //Рефакторинг
    func returnTime(time: Int) -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(self))
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: time * 3600)!
        let hours = calendar.component(.hour, from: date as Date)
        let minute = calendar.component(.minute, from: date as Date)
        let compare = String(format:"%d:%02d", hours, minute)
        return compare
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
    
    func switcher(_ num: Int) -> UIColor {
        switch num {
        case 0...35:
       return .green
        case 35...75:
        return .yellow
        case 75...105:
        return .orange
        case 105...140:
        return .systemRed
        case 140...210:
        return .magenta
        case 210...:
        return .red
        default:
       break
        }
        return .white
    }
    
}
extension UIView {

  
        func addColors(colors: [UIColor], withPercentage percentages: [Double]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        var colorsArray: [CGColor] = []
        var locationsArray: [NSNumber] = []
        var total = 0.0
        locationsArray.append(0.0)
        for (index, color) in colors.enumerated() {
            colorsArray.append(color.cgColor)
            colorsArray.append(color.cgColor)
            if index+1 < percentages.count {
                total += percentages[index]
                let location: NSNumber = NSNumber(value: total/100)
                locationsArray.append(location)
                locationsArray.append(location)
            }
        }
        locationsArray.append(1.0)
        gradientLayer.colors = colorsArray
        gradientLayer.locations = locationsArray
        self.backgroundColor = .clear
        self.layer.addSublayer(gradientLayer)
        
    }
}




