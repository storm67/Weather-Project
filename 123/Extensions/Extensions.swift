//
//  Extensions.swift
//  123
//
//  Created by gdml on 06/05/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import Foundation
import UIKit
import SkeletonView

let cellID = "cell"

extension String {
    
    func format() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd"
        let finish = dateFormatterPrint.string(from: Date())
        return finish
    }
    
    static var clearNavigationController: String {
        "ClearNavigationController"
    }
    
    static var citySelector: String {
        "CitySelector"
    }
    
    static var pagesViewController: String {
        "PagesViewController"
    }
    
    static var pageViewController: String {
        "PageViewController"
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
    
    static func nowState(timeOffset: Int) -> String {
    let time = timeOffset * 3600
    let date = Date()
    var calendar = Calendar.current
    calendar.timeZone = TimeZone(secondsFromGMT: time)!
    let hour = calendar.component(.hour, from: date)
    let minute = calendar.component(.minute, from: date)
    return "\(hour):\(minute)"
    }
    
    func convertToHours(time: Int) -> Int {
        let date = NSDate(timeIntervalSince1970: TimeInterval(self))
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: time * 3600)!
        let hour = calendar.component(.hour, from: date as Date)
        let minute = calendar.component(.minute, from: date as Date)
        return (hour * 60) + minute
    }
    
    enum Interval {
        case since1970
        case base
    }
    
    func returnTime(time: Int, interval: Interval) -> String {
        let date: NSDate
        switch interval {
        case .since1970:
        date = NSDate(timeIntervalSince1970: TimeInterval(self))
        case .base:
        date = Date() as NSDate
        }
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: time * 3600)!
        let hours = calendar.component(.hour, from: date as Date)
        let minute = calendar.component(.minute, from: date as Date)
        let compare = String(format:"%d:%02d", hours, minute)
        return compare
    }
    
    func current() -> Int {
        let date = Date()
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: self * 3600)!
        let hour = calendar.component(.hour, from: date as Date)
        return hour
    }
    
}

extension UIImageView {
    
    func switchImage(_ image: String) {
        switch image.description {
        case let str where str.contains("ив") || str.contains("ожд"):
            self.image = UIImage(named: "12")!
        case let str where str.contains("Солн"):
            self.image = UIImage(named: "1")!
        case let str where str.contains("Преимущественно облачно"):
            self.image = UIImage(named: "6")!
        case let str where str.contains("Переменная облачность") || str.contains("Небольшая облачность"):
            self.image = UIImage(named: "4")!
        case let str where str.contains("Снег"):
            self.image = UIImage(named: "15")!
        case let str where str.contains("Небольшой снег"):
            self.image = UIImage(named: "20")!
        case let str where str.contains("Холодно"):
            self.image = UIImage(named: "snowflake")!
        case let str where str.contains("Небольшая облачность, небольшой снег"):
            self.image = UIImage(named: "20")!
        case let str where str.contains("Преимущественно ясно"):
            self.image = UIImage(named: "1")!
        case let str where str.contains("Облачно"):
            self.image = UIImage(named: "4")!
        case let str where str.contains("Грозы"):
            self.image = UIImage(named: "23")!
        default:
            self.image = UIImage()
        }
    }
    
    func anotherSwitchImage(_ time: Int) {
        switch time {
         case 21...23:
         self.image = UIImage(named: "Night")
         case 0...4:
         self.image = UIImage(named: "Night")
         case 4...10:
         self.image = UIImage(named: "Sunset")
         case 10...21:
         self.image = UIImage(named: "Sunny")
         default:
        break
         }
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

extension Notification.Name {
    public static let notify = Notification.Name(rawValue: "notify")
}

extension UIImage {
    
    func imageResize(sizeChange:CGSize) -> UIImage {
        
        let hasAlpha = true
        let scale: CGFloat = 0.0 // Use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        self.draw(in: CGRect(origin: CGPoint.zero, size: sizeChange))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage!
    }
    
    func tint(with color: UIColor) -> UIImage {
        var image = withRenderingMode(.alwaysTemplate)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.set()

        image.draw(in: CGRect(origin: .zero, size: size))
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}

extension UIPanGestureRecognizer {
    func projectedLocation(decelerationRate: UIScrollView.DecelerationRate) -> CGPoint {
        let velocityOffset = velocity(in: view).projectedOffset(decelerationRate: .normal)
        let projectedLocation = location(in: view!) + velocityOffset
        return projectedLocation
    }
}

extension CGPoint {
    func projectedOffset(decelerationRate: UIScrollView.DecelerationRate) -> CGPoint {
        return CGPoint(x: x.projectedOffset(decelerationRate: decelerationRate),
                       y: y.projectedOffset(decelerationRate: decelerationRate))
    }
}

extension CGFloat { // Velocity value
    func projectedOffset(decelerationRate: UIScrollView.DecelerationRate) -> CGFloat {
        // Magic formula from WWDC
        let multiplier = 1 / (1 - decelerationRate.rawValue) / 400
        return self * multiplier
    }
}

extension CGPoint {
    static func +(left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x + right.x,
                       y: left.y + right.y)
    }
}


class InstantPanGestureRecognizer: UIPanGestureRecognizer {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        if (self.state == .began) { return }
        super.touchesBegan(touches, with: event)
        self.state = .began
    }
}

extension UIViewController {
    
    func hide() {
        guard let first = view.subviews[1].subviews[0] as? UIButton else { return }
        first.setTitle("Текущее местоположение", for: .normal)
        view.subviews[0].subviews.forEach { item in
            item.removeFromSuperview()
        }
        let loader = Loader()
        loader.frame = CGRect(x: 100, y: 100, width: 25, height: 25)
        view.subviews[0].addSubview(loader)
        loader.center = view.subviews[1].center
    }
    
    func unhide() {
        view.subviews[0].subviews.forEach { item in
            item.isSkeletonable = false
            DispatchQueue.main.async {
            item.hideSkeleton()
            }
        }
    }
}
