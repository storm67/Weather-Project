//
//  StatsView.swift
//  123
//
//  Created by Storm67 on 26/03/2021.
//  Copyright © 2021 gdml. All rights reserved.
//

import Foundation
import UIKit

class StatsView: UIView {
    
    var wind: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ветер"
        label.font = label.font.withSize(15)
        label.textColor = .gray
        return label
    }()
    var humidity: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Влажность"
        label.font = label.font.withSize(15)
        label.textColor = .gray
        return label
    }()
    var pressure: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Давление"
        label.font = label.font.withSize(15)
        label.textColor = .gray
        return label
    }()
    var windLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "DINAlternate-Bold", size: 17)
        label.textColor = .black
        return label
    }()
    var humidityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "DINAlternate-Bold", size: 17)
        label.textColor = .black
        return label
    }()
    var pressureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "DINAlternate-Bold", size: 17)
        label.textColor = .black
        return label
    }()
    
     override init(frame: CGRect) {
           super.init(frame: frame)
           layout()
           backgroundColor = .black
       }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func layout() {
        addSubview(wind)
        addSubview(humidity)
        addSubview(pressure)
        addSubview(windLabel)
        addSubview(humidityLabel)
        addSubview(pressureLabel)
        NSLayoutConstraint.activate([
        wind.leftAnchor.constraint(equalTo: leftAnchor, constant: 25),
        wind.topAnchor.constraint(equalTo: topAnchor, constant: 20),
        windLabel.topAnchor.constraint(equalTo: wind.topAnchor, constant: 10),
        windLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 27),
        windLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
        windLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
        humidity.leftAnchor.constraint(equalTo: wind.leftAnchor, constant: 130),
        humidity.topAnchor.constraint(equalTo: topAnchor, constant: 20),
        humidity.rightAnchor.constraint(equalTo: pressure.rightAnchor, constant: 0),
        humidityLabel.topAnchor.constraint(equalTo: humidity.topAnchor, constant: 10),
        humidityLabel.leftAnchor.constraint(equalTo: windLabel.leftAnchor, constant: 152.5),
        humidityLabel.rightAnchor.constraint(equalTo: pressureLabel.rightAnchor, constant: -70),
        humidityLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
        pressure.leftAnchor.constraint(equalTo: humidity.leftAnchor, constant: 145),
        pressure.topAnchor.constraint(equalTo: topAnchor, constant: 20),
        pressure.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
        pressureLabel.topAnchor.constraint(equalTo: wind.topAnchor, constant: 10),
        pressureLabel.leftAnchor.constraint(equalTo: humidityLabel.leftAnchor, constant: 140),
        pressureLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
        pressureLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
        ])
    }
    
    func update(wind: Int, direction: String, pressure: Int, humidity: Int) {
        DispatchQueue.main.async {
            self.wind.text = "Ветер \(direction)"
            self.windLabel.text = "\(wind) км/ч"
            self.pressureLabel.text = "\(pressure) бар"
            self.humidityLabel.text = "\(humidity)%"
        }
    }
    
}


