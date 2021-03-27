//
//  AirQualityView.swift
//  123
//
//  Created by Storm67 on 07/01/2021.
//  Copyright © 2021 gdml. All rights reserved.
//

import Foundation
import UIKit

class AirQualityView: UIView {
    
    fileprivate let graph = UIView(frame: CGRect(x: 187, y: -60, width: 10, height: 360))
    
    var good: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Хорошее"
        label.font = UIFont(name: "Arial-BoldMT", size: 10)
        label.textColor = .black
        return label
    }()
    
    var danger: UILabel = {
           let label = UILabel()
           label.translatesAutoresizingMaskIntoConstraints = false
           label.text = "Плохое"
           label.font = UIFont(name: "Arial-BoldMT", size: 10)
           label.textColor = .black
           return label
   }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        graph.backgroundColor = .none
        graph.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        addSubview(graph)
        let colors: [UIColor] = [.red, .magenta, .systemRed, .orange, .yellow, .green]
        let percentages: [Double] = [40, 20, 10, 10, 10, 10]
        graph.addColors(colors: colors, withPercentage: percentages)
        layout()
    }
    
    func layout() {
    addSubview(good)
    addSubview(danger)
    NSLayoutConstraint.activate([
    good.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 14),
    good.topAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.topAnchor, constant: 125),
    good.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
    danger.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 335),
    danger.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 125),
    danger.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
    ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}
