//
//  GradientButton.swift
//  123
//
//  Created by Storm67 on 18/12/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import UIKit

class GradientButton: UIButton {

        override func layoutSubviews() {
            super.layoutSubviews()
            gradientLayer.frame = bounds
        }

        private lazy var gradientLayer: CAGradientLayer = {
            let l = CAGradientLayer()
            l.frame = self.bounds
            l.colors = [UIColor.red.cgColor, UIColor.gray.cgColor]
            l.startPoint = CGPoint(x: 0, y: 0.5)
            l.endPoint = CGPoint(x: 1, y: 0.5)
            l.cornerRadius = 16
            layer.insertSublayer(l, at: 0)
            return l
        }()
}
