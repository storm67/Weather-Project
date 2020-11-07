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
    
    func switchImage<T>(_ imageView: inout T, _ image: String) -> UIImage where T: UIView {
        switch image.description {
        case let str where str.contains("ив") || str.contains("ожд"):
            rotation(imageView)
            NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 20),
            imageView.widthAnchor.constraint(equalToConstant: 20)
            ])
            return UIImage(named: "1")!
        case let str where str.contains("олн"):
            rotation(imageView)
            NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 25),
            imageView.heightAnchor.constraint(equalToConstant: 25)
            ])
            return UIImage(named: "1")!
        case let str where str.contains("бла"):
            addRain(imageView)
            NSLayoutConstraint.activate([
                imageView.heightAnchor.constraint(equalToConstant: 20),
                imageView.widthAnchor.constraint(equalToConstant: 20)
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
    
    func addRain(_ view: UIView) {
        let emitter = CAEmitterLayer()
        let cell = CAEmitterCell()
        emitter.position = CGPoint(x: (view.superview?.frame.origin.x)! + 10, y: (view.superview?.frame.origin.y)! + 26)
        emitter.emitterShape = CAEmitterLayerEmitterShape.line
        emitter.emitterMode = .surface
        emitter.emitterSize = CGSize(width: 18, height: view.frame.height)
        emitter.renderMode = .unordered
        emitter.contentsGravity = .bottom
        emitter.speed = 0.5
        cell.scale = 0.03
        cell.color = UIColor.red.cgColor
        cell.emissionLongitude = 222
        cell.emissionRange = CGFloat.pi
        cell.lifetime = 0.1
        cell.birthRate = 5
        cell.velocity = 30
        cell.yAcceleration = 300
        cell.contents = resizeImage(image: #imageLiteral(resourceName: "rain"), targetSize: CGSize(width: 800, height: 300)).cgImage
        emitter.emitterCells = [cell]
        cell.speed = 0.5
        cell.alphaSpeed = -1
        view.layer.addSublayer(emitter)
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
