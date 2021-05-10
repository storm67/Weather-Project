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

        weak var delegate: Reciever?
    
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
            label.textColor = .white
            label.numberOfLines = 5
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center
            return label
        }()
    
        var policy: UILabel = {
            let label = UILabel()
            label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            label.attributedText = NSAttributedString(string: "Политика конфиденциальности", attributes:
            [.underlineStyle: NSUnderlineStyle.single.rawValue])
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    
        var confirm: UIButton = {
            let confirm = UIButton()
            confirm.addTarget(self, action: #selector(test), for: .touchUpInside)
            confirm.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            confirm.titleLabel?.textColor = .black
            confirm.setTitle("Предоставить", for: .normal)
            confirm.translatesAutoresizingMaskIntoConstraints = false
            confirm.layer.cornerRadius = 5
            confirm.layer.masksToBounds = true
            return confirm
        }()
    
        var reject: UIButton = {
            let reject = UIButton()
            let string = NSAttributedString(string: "Отказать", attributes:
            [.underlineStyle: NSUnderlineStyle.single.rawValue])
            reject.backgroundColor = .clear
            reject.titleLabel?.textColor = .white
            reject.setAttributedTitle(string, for: .normal)
            reject.translatesAutoresizingMaskIntoConstraints = false
            reject.layer.cornerRadius = 5
            reject.layer.masksToBounds = true
            return reject
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
            addSubview(policy)
            addSubview(label)
            addSubview(confirm)
            addSubview(reject)
            NSLayoutConstraint.activate([
                reject.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
                reject.topAnchor.constraint(equalTo: topAnchor, constant: 450),
                reject.heightAnchor.constraint(equalToConstant: 50),
                reject.widthAnchor.constraint(equalToConstant: 150),
                confirm.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
                confirm.topAnchor.constraint(equalTo: topAnchor, constant: 400),
                confirm.heightAnchor.constraint(equalToConstant: 50),
                confirm.widthAnchor.constraint(equalToConstant: 150),
                image.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
                image.topAnchor.constraint(equalTo: topAnchor, constant: 40),
                image.heightAnchor.constraint(equalToConstant: 200),
                image.widthAnchor.constraint(equalToConstant: 280),
                topSlider.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
                topSlider.topAnchor.constraint(equalTo: topAnchor, constant: 10),
                topSlider.heightAnchor.constraint(equalToConstant: 7.5),
                topSlider.widthAnchor.constraint(equalToConstant: 40),
                label.topAnchor.constraint(equalTo: image.topAnchor, constant: 200),
                label.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
                label.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
                label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -550),
                policy.topAnchor.constraint(equalTo: topAnchor, constant: 350),
                policy.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            ])
        }
    
    @objc func test() {
        delegate?.getTrigger()
    }
}
