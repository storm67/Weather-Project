//
//  Circle.swift
//  123
//
//  Created by Storm67 on 17/01/2021.
//  Copyright © 2021 gdml. All rights reserved.
//

import Foundation
import UIKit

class Circle: UIView {
    let fillLayer = CAShapeLayer()
    var strokeColor: UIColor
    var fillColor: UIColor
    init(frame: CGRect, strokeColor: UIColor, fillColor: UIColor = .clear) {
        self.strokeColor = strokeColor
        self.fillColor = fillColor
        super.init(frame: frame)
        backgroundColor = .none
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.width, y: frame.height), radius: frame.height / 2, startAngle: CGFloat(0), endAngle: CGFloat.pi * 2, clockwise: true)
        strokeColor.setStroke()
        fillColor.setFill()
        circlePath.lineWidth = 1
        circlePath.stroke()
        fillLayer.path = circlePath.cgPath
        fillLayer.fillColor = UIColor.white.cgColor
        layer.addSublayer(fillLayer)
    }

}

