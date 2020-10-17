//
//  GeneralView.swift
//  123
//
//  Created by gdml on 30/04/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import Foundation
import UIKit
import SwiftChart

final class MainControllerView: UIView {
    
    var segmentedControl: CustomSegmentedControl = {
        let interfaceSegmented = CustomSegmentedControl()
        interfaceSegmented.setButtonTitles(buttonTitles: ["12 часов","5 дней"])
        interfaceSegmented.selectorViewColor = .white
        interfaceSegmented.selectorTextColor = .white
        interfaceSegmented.translatesAutoresizingMaskIntoConstraints = false
        return interfaceSegmented
    }()
    
    var myTableView: UITableView! = {
        var myTableView = UITableView()
        myTableView.separatorColor = .white
        myTableView.tableFooterView = UIView(frame: .zero)
        myTableView.backgroundColor = .purple
        myTableView.rowHeight = 57.0
        myTableView.sectionHeaderHeight = 100
        myTableView.register(CustomCell.self, forCellReuseIdentifier: "cell")
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        myTableView.layer.cornerRadius = 5
        myTableView.layer.masksToBounds = true
        myTableView.isScrollEnabled = false
        return myTableView
    }()
    
    var charts: Chart = {
        let chart = Chart()
        chart.translatesAutoresizingMaskIntoConstraints = false
        return chart
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
        addSubview(charts)
        scrollView.addSubview(myTableView)
        scrollView.contentSize = CGSize(width:frame.size.width, height: 690)
        headerView.addSubview(segmentedControl)
        headerView.addSubview(cityLabel)
        segmentedControl.backgroundColor = .purple
        headerView.addSubview(tempLabel)
        headerOfMainView.addSubview(locationIcon)
        headerOfMainView.addSubview(location)
        NSLayoutConstraint.activate([
        charts.centerXAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.centerXAnchor),
        charts.centerYAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.centerYAnchor),
        myTableView.centerXAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.centerXAnchor),
        myTableView.topAnchor.constraint(equalTo: imageView.safeAreaLayoutGuide.bottomAnchor, constant: 10),
        myTableView.widthAnchor.constraint(equalToConstant: 355),
        myTableView.heightAnchor.constraint(equalToConstant: 400),
        headerOfMainView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
        headerOfMainView.centerXAnchor.constraint(equalTo: centerXAnchor),
        headerOfMainView.heightAnchor.constraint(equalToConstant: 40),
        headerOfMainView.widthAnchor.constraint(equalToConstant: 400),
        scrollView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
        scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
        scrollView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
        cityLabel.bottomAnchor.constraint(lessThanOrEqualTo: tempLabel.safeAreaLayoutGuide.bottomAnchor, constant: cityLabel.frame.height),
        cityLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 5),
        segmentedControl.centerYAnchor.constraint(equalTo: headerView.centerYAnchor, constant: 28),
        segmentedControl.centerXAnchor.constraint(equalTo: headerView.centerXAnchor, constant: 89),
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
        imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant:
            45),
        imageView.heightAnchor.constraint(equalToConstant: 230),
        imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.95),
        locationIcon.topAnchor.constraint(equalTo: location.topAnchor, constant: 10),
        locationIcon.leadingAnchor.constraint(equalTo: location.leadingAnchor, constant: -25),
        location.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
        location.centerYAnchor.constraint(equalTo: headerOfMainView.centerYAnchor, constant: -6),
        tempLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 5),
        tempLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 2)
        ])
    }
    
    func updateData(_ temp: String,_ city: String,_ value: String) {
        tempLabel.text = temp
        cityLabel.text = city
        location.setTitle(value, for: .normal)
    }
    
}

