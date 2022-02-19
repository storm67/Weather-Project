//
//  Loader.swift
//  123
//
//  Created by Storm67 on 11/04/2021.
//  Copyright © 2021 gdml. All rights reserved.
//

import Foundation
import UIKit

class Loader: UIView {
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpAnimation(in: layer, size: CGSize(width: 25, height: 25), color: .orange)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpAnimation(in layer: CALayer, size: CGSize, color: UIColor) {
            let beginTime: Double = 0.5
            let strokeStartDuration: Double = 1.2
            let strokeEndDuration: Double = 0.7

            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
            rotationAnimation.byValue = Float.pi * 2
            rotationAnimation.timingFunction = CAMediaTimingFunction(name: .linear)

            let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
            strokeEndAnimation.duration = strokeEndDuration
            strokeEndAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.4, 0.0, 0.2, 1.0)
            strokeEndAnimation.fromValue = 0
            strokeEndAnimation.toValue = 1

            let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
            strokeStartAnimation.duration = strokeStartDuration
            strokeStartAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.4, 0.0, 0.2, 1.0)
            strokeStartAnimation.fromValue = 0
            strokeStartAnimation.toValue = 1
            strokeStartAnimation.beginTime = beginTime

            let groupAnimation = CAAnimationGroup()
            groupAnimation.animations = [rotationAnimation, strokeEndAnimation, strokeStartAnimation]
            groupAnimation.duration = strokeStartDuration + beginTime
            groupAnimation.repeatCount = .infinity
            groupAnimation.isRemovedOnCompletion = false
            groupAnimation.fillMode = .forwards

            let shape = CAShapeLayer()
            let path = UIBezierPath()
            path.addArc(withCenter: CGPoint(x: size.width / 2, y: size.height / 2),
                              radius: size.width / 2,
                              startAngle: -(.pi / 2),
                              endAngle: .pi + .pi / 2,
                              clockwise: true)
            shape.fillColor = nil
            shape.strokeColor = color.cgColor
            shape.lineWidth = 2
            shape.path = path.cgPath
        
            let frame = CGRect(
                x: (layer.bounds.width - size.width) / 2,
                y: (layer.bounds.height - size.height) / 2,
                width: size.width,
                height: size.height
            )

            shape.frame = frame
            shape.add(groupAnimation, forKey: "animation")
            layer.addSublayer(shape)
        }
}
