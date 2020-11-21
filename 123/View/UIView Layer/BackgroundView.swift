//
//  backgroundView.swift
//  123
//
//  Created by gdml on 01/04/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import Foundation
import UIKit

final class BackgroundView: NSObject {
    
    fileprivate var rain: RainController!
    
    func switchImage<T>(_ imageView: T, _ image: String) -> UIImage where T: UIView {
        switch image.description {
        case let str where str.contains("ив") || str.contains("ожд"):
            //rotation(imageView)
            NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 25),
            imageView.widthAnchor.constraint(equalToConstant: 25)
            ])
            return UIImage(named: "1")!
        case let str where str.contains("олн"):
            //rotation(imageView)
            NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 35),
            imageView.heightAnchor.constraint(equalToConstant: 30)
            ])
            return UIImage(named: "1")!
        case let str where str.contains("бла"):
            //addRain(imageView)
            NSLayoutConstraint.activate([
                imageView.heightAnchor.constraint(equalToConstant: 20),
                imageView.widthAnchor.constraint(equalToConstant: 25)
            ])
            return UIImage(named: "3")!
        case let str where str.contains("жд"):
            rotation(imageView)
            return UIImage(named: "1")!
        default:
            return UIImage()
        }
}
    func rotation(_ view: UIView) {
    let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
    rotation.toValue = NSNumber(value: Double.pi * 2)
    rotation.duration = 25
    rotation.isCumulative = true
    rotation.repeatCount = Float.greatestFiniteMagnitude
    view.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    func random() -> UIImage {
        let random = Int.random(in: 1...14)
        switch random {
        case 1: return UIImage(named: "Altern")!
        case 2: return UIImage(named: "DayMountain")!
        case 3: return UIImage(named: "DesertMountain")!
        case 4: return UIImage(named: "Evening")!
        case 5: return UIImage(named: "EveningLast")!
        case 6: return UIImage(named: "MountainEvening")!
        case 7: return UIImage(named: "MountainsSmoke")!
        case 8: return UIImage(named: "Night1")!
        case 9: return UIImage(named: "NightMountain")!
        case 10: return UIImage(named: "NorthernLights")!
        case 11: return UIImage(named: "Paris")!
        case 12: return UIImage(named: "PreDay")!
        case 13: return UIImage(named: "riverForest")!
        case 14: return UIImage(named: "UFO")!
        default:
        return UIImage()
        }
    }
    
    func addRain(_ view: UIView) {
        rain = RainController(view: view, frame: view.frame)
        rain.createBackground()
        rain.start()
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size

        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }

        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage() }
        UIGraphicsEndImageContext()

        return newImage
    }
}
protocol BackViewProtocol {
    func switchImage(_ image: String) -> UIImage
}
