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
    
    weak var delegate: MyViewDelegate?
    
    var cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Москва"
        label.font = label.font.withSize(35)
        return label
    }()
    
    let tempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "15°"
        label.font = label.font.withSize(25)
        return label
    }()
    
    
    let imageView: UIImageView = {
        let label = UIImageView()
        label.image = UIImage(named: "main")?.imageResize(sizeChange: CGSize(width: 360,height: 230))
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let searchIcon: UIButton = {
        let label = UIButton()
        label.setImage(UIImage(named: "search"), for: .normal)
        label.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 230, right: 230)
        label.imageView?.contentMode = .scaleAspectFill
        label.contentHorizontalAlignment = .fill
        label.contentVerticalAlignment = .fill
        label.translatesAutoresizingMaskIntoConstraints = false
        label.addTarget(self, action: #selector(buttonTapAction), for: .touchUpInside)
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
    let menu: UIButton = {
        let label = UIButton()
        label.setImage(UIImage(named: "menu"), for: .normal)
        label.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 225, right: 225)
        label.imageView?.contentMode = .scaleAspectFill
        label.contentHorizontalAlignment = .fill
        label.contentVerticalAlignment = .fill
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.bounces = false
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
        
        layoutIfNeeded()
        layout()
        backgroundColor = .white
    }
    func layout() {
        addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(searchIcon)
        scrollView.addSubview(locationIcon)
        scrollView.addSubview(location)
        scrollView.addSubview(menu)
        scrollView.addSubview(cityLabel)
        scrollView.addSubview(tempLabel)
        scrollView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        scrollView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        tempLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 70).isActive = true
        tempLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10).isActive = true
        cityLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 45).isActive = true
        cityLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 8).isActive = true
        imageView.topAnchor.constraint(equalTo: location.topAnchor, constant:
            45).isActive = true
        imageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 200).isActive = true
        imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 8).isActive = true
        searchIcon.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 6).isActive = true
        searchIcon.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20).isActive = true
        locationIcon.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 26).isActive = true
        locationIcon.leadingAnchor.constraint(equalTo: searchIcon.leadingAnchor, constant: 100).isActive = true
        menu.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20).isActive = true
        menu.leadingAnchor.constraint(equalTo: location.leadingAnchor, constant: 208).isActive = true
        location.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 17).isActive = true
        location.leadingAnchor.constraint(equalTo: locationIcon.leadingAnchor, constant: 25).isActive = true
    }
    
    func updateData(temp: String) {
        tempLabel.text = temp
    }
    
    @objc fileprivate func buttonTapAction() {
        delegate?.didTapButton()
    }
    
}

extension UIImage {
    
    func imageResize (sizeChange:CGSize)-> UIImage {
        
        let hasAlpha = true
        let scale: CGFloat = 0.0 // Use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        self.draw(in: CGRect(origin: CGPoint.zero, size: sizeChange))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage!
    }
    
}
