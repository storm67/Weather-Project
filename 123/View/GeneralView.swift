//
//  GeneralView.swift
//  123
//
//  Created by gdml on 30/04/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import Foundation
import UIKit

final class CustomView: UIView {
    
    var segmentedControl: CustomSegmentedControl = {
        let interfaceSegmented = CustomSegmentedControl()
        interfaceSegmented.setButtonTitles(buttonTitles: ["12/H","5Days"])
        interfaceSegmented.selectorViewColor = .white
        interfaceSegmented.selectorTextColor = .white
        interfaceSegmented.translatesAutoresizingMaskIntoConstraints = false
        return interfaceSegmented
    }()
    var tempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Москва"
        label.font = UIFont.boldSystemFont(ofSize: 35.0)
        label.textColor = .white
        return label
    }()
    
    let cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "15°"
        label.textColor = .white
        label.sizeToFit()
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.font = label.font.withSize(25)
        label.clipsToBounds = true
        return label
    }()
    
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "main")
        image.layer.cornerRadius = 5
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let locationIcon: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "navigation"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 496, right: 496)
        button.imageView?.contentMode = .scaleAspectFill
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let location: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Current Location", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .purple
        return view
    }()
    
    let headerOfMainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.bounces = false
        v.isScrollEnabled = true
        v.bouncesZoom = false
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        return v
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        backgroundColor = .white
    }
    
    func layout() {
        addSubview(headerView)
        scrollView.addSubview(imageView)
        addSubview(scrollView)
        addSubview(headerOfMainView)
        scrollView.contentSize = CGSize(width:frame.size.width, height: 690)
        headerView.addSubview(segmentedControl)
        headerView.addSubview(cityLabel)
        segmentedControl.backgroundColor = .purple
        headerView.addSubview(tempLabel)
        headerOfMainView.addSubview(locationIcon)
        headerOfMainView.addSubview(location)
        headerOfMainView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        headerOfMainView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        headerOfMainView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        headerOfMainView.widthAnchor.constraint(equalToConstant: 400).isActive = true
        scrollView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        let constraint = cityLabel.frame.height
        cityLabel.bottomAnchor.constraint(lessThanOrEqualTo: tempLabel.safeAreaLayoutGuide.bottomAnchor, constant: constraint).isActive = true
        cityLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 5).isActive = true
        cityLabel.trailingAnchor.constraint(lessThanOrEqualTo: headerView.trailingAnchor, constant: -5).isActive = true
        segmentedControl.centerYAnchor.constraint(equalTo: headerView.centerYAnchor, constant: 28).isActive = true
        segmentedControl.centerXAnchor.constraint(equalTo: headerView.centerXAnchor, constant: 100).isActive = true
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant:
            45).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 230).isActive = true
        imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.95).isActive = true
        locationIcon.topAnchor.constraint(equalTo: location.topAnchor, constant: 10).isActive = true
        locationIcon.leadingAnchor.constraint(equalTo: location.leadingAnchor, constant: -25).isActive = true
        location.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        location.centerYAnchor.constraint(equalTo: headerOfMainView.centerYAnchor, constant: -6).isActive = true
        tempLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 5).isActive = true
        tempLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 2).isActive = true
    }
    
    func updateData(_ temp: String,_ city: String,_ value: String) {
        tempLabel.text = temp
        cityLabel.text = city
        location.setTitle(value, for: .normal)
    }
    
}

