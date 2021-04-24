//
//  GradientButton.swift
//  123
//
//  Created by Storm67 on 18/12/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import UIKit

class GradientView: UIView {

        override func layoutSubviews() {
            super.layoutSubviews()
            gradientLayer.frame = bounds
        }

        var topSlider: UIView = {
             let insideView = UIView()
             insideView.translatesAutoresizingMaskIntoConstraints = false
             insideView.backgroundColor = .lightGray
             insideView.layer.cornerRadius = 3
             insideView.layer.masksToBounds = true
             return insideView
         }()
        
        var image: UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.layer.cornerRadius = 3
            imageView.image = UIImage(named: "map")
            imageView.contentMode = .scaleAspectFit
            imageView.layer.masksToBounds = true
            return imageView
        }()
        
        private lazy var gradientLayer: CAGradientLayer = {
            let l = CAGradientLayer()
            l.frame = self.bounds
            l.colors = [#colorLiteral(red: 0.2848043144, green: 0.3504746556, blue: 1, alpha: 1).cgColor, #colorLiteral(red: 0.5325469375, green: 0.5306532979, blue: 1, alpha: 1).cgColor]
            l.startPoint = CGPoint(x: 0, y: 0)
            l.endPoint = CGPoint(x: 1, y: 1)
            l.cornerRadius = 16
            layer.insertSublayer(l, at: 0)
            return l
        }()
        
        var label: UILabel = {
            let label = UILabel()
            label.text = Defaults.label
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    
        var policy: UILabel = {
            let label = UILabel()
            label.text = 
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        func layout() {
            addSubview(topSlider)
            addSubview(image)
            NSLayoutConstraint.activate([
                image.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
                image.topAnchor.constraint(equalTo: topAnchor, constant: 40),
                image.heightAnchor.constraint(equalToConstant: 200),
                image.widthAnchor.constraint(equalToConstant: 280),
                topSlider.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
                topSlider.topAnchor.constraint(equalTo: topAnchor, constant: 10),
                topSlider.heightAnchor.constraint(equalToConstant: 7.5),
                topSlider.widthAnchor.constraint(equalToConstant: 40)
            ])
        }
}
