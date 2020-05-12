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
        let label = UIImageView()
        label.image = UIImage(named: "main")
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let locationIcon: UIButton = {
        let label = UIButton()
        label.setImage(UIImage(named: "navigation"), for: .normal)
        label.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 496, right: 496)
        label.imageView?.contentMode = .scaleAspectFill
        label.contentHorizontalAlignment = .fill
        label.contentVerticalAlignment = .fill
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let location: UIButton = {
        let label = UIButton()
        label.setTitleColor(.black, for: .normal)
        label.setTitle("Current Location", for: .normal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        setNeedsLayout()
        layoutSubviews()
        setNeedsDisplay()
        backgroundColor = .white
    }
    
    func layout() {
        addSubview(scrollView)
        addSubview(headerView)
        scrollView.contentSize = CGSize(width:frame.size.width, height: 680)
        headerView.addSubview(cityLabel)
        headerView.addSubview(tempLabel)
        scrollView.addSubview(imageView)
        scrollView.addSubview(headerOfMainView)
        headerOfMainView.addSubview(locationIcon)
        headerOfMainView.addSubview(location)
        headerOfMainView.topAnchor.constraint(equalTo: scrollView.frameLayoutGuide.topAnchor, constant: 15).isActive = true
        headerOfMainView.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: 0).isActive = true
        headerOfMainView.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: 0).isActive = true
        headerOfMainView.heightAnchor.constraint(equalToConstant: 38).isActive = true
        headerOfMainView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        scrollView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        scrollView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        let constraint = cityLabel.frame.height
        cityLabel.bottomAnchor.constraint(lessThanOrEqualTo: tempLabel.safeAreaLayoutGuide.bottomAnchor, constant: constraint).isActive = true
        cityLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 5).isActive = true
        cityLabel.trailingAnchor.constraint(lessThanOrEqualTo: headerView.trailingAnchor, constant: -5).isActive = true
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant:
            43).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 230).isActive = true
        imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.95).isActive = true
        locationIcon.topAnchor.constraint(equalTo: location.topAnchor, constant: 10).isActive = true
        locationIcon.leadingAnchor.constraint(equalTo: location.leadingAnchor, constant: -25).isActive = true
        location.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        location.centerYAnchor.constraint(equalTo: headerOfMainView.centerYAnchor, constant: -4).isActive = true
        tempLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 5).isActive = true
        tempLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 2).isActive = true
    }
    
    func updateData(_ temp: String,_ city: String,_ value: String) {
        tempLabel.text = temp
        cityLabel.text = city
        location.setTitle(value, for: .normal)
    }
    
}

