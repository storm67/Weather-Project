//
//  GeneralView.swift
//  123
//
//  Created by gdml on 30/04/2020.
//  Copyright © 2020 gdml. All rights reserved.
//
import UIKit
import SwiftChart

final class MainControllerView: UIView {
    
    var segmentedControl: CustomSegmentedControl = {
        let interfaceSegmented = CustomSegmentedControl()
        interfaceSegmented.setButtonTitles(buttonTitles: ["5 дней","12 часов"])
        interfaceSegmented.selectorViewColor = .white
        interfaceSegmented.selectorTextColor = .white
        interfaceSegmented.backgroundColor = UIColor(hexFromString: "#929aef")
        interfaceSegmented.translatesAutoresizingMaskIntoConstraints = false
        return interfaceSegmented
    }()
    
    var tempOriginal: UILabel = {
        let labelDate = UILabel()
        labelDate.text = "Hello"
        labelDate.translatesAutoresizingMaskIntoConstraints = false
        return labelDate
    }()
    
    var imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "1")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var tableView: UITableView = {
        var myTableView = UITableView()
        myTableView.separatorColor = .white
        myTableView.tableFooterView = UIView(frame: .zero)
        myTableView.backgroundColor = UIColor(hexFromString: "#929aef")
        myTableView.rowHeight = 68.0
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
        chart.showXLabelsAndGrid = false
        chart.showYLabelsAndGrid = false
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
    
    let temp: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tuesday"
        label.textColor = .black
        label.font = UIFont(name: "ArialMT", size: 18)
        return label
    }()
    
    let date: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "15 Dec 2020"
        label.textColor = .black
        label.font = UIFont(name: "AvenirNext-Regular", size: 15)
        return label
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
        view.backgroundColor = UIColor(hexFromString: "#929aef")
        return view
    }()
    
    let secondView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 15
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 6
        return view
    }()
    
    let headerOfMainView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9348890868, green: 0.9348890868, blue: 0.9348890868, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.bounces = false
        v.isScrollEnabled = true
        v.bouncesZoom = false
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = #colorLiteral(red: 0.9348890868, green: 0.9348890868, blue: 0.9348890868, alpha: 1)
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
        addSubview(scrollView)
        addSubview(headerOfMainView)
        scrollView.addSubview(tempOriginal)
        scrollView.addSubview(charts)
        scrollView.addSubview(headerView)
        scrollView.addSubview(secondView)
        scrollView.addSubview(tableView)
        scrollView.contentSize = CGSize(width:frame.size.width, height: 1111)
        headerView.addSubview(segmentedControl)
        headerView.addSubview(cityLabel)
        headerView.addSubview(tempLabel)
        secondView.addSubview(imageView)
        secondView.addSubview(tempOriginal)
        secondView.addSubview(temp)
        secondView.addSubview(date)
        headerOfMainView.addSubview(locationIcon)
        headerOfMainView.addSubview(location)
        NSLayoutConstraint.activate([
        secondView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
        secondView.topAnchor.constraint(equalTo: headerOfMainView.safeAreaLayoutGuide.bottomAnchor, constant: 10),
        secondView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.95),
        secondView.heightAnchor.constraint(equalToConstant: 240),
        tableView.centerXAnchor.constraint(equalTo: centerXAnchor),
        tableView.topAnchor.constraint(equalTo: secondView.safeAreaLayoutGuide.bottomAnchor, constant: 60),
        tableView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.95),
        tableView.heightAnchor.constraint(equalToConstant: 450),
        headerOfMainView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
        headerOfMainView.centerXAnchor.constraint(equalTo: centerXAnchor),
        headerOfMainView.heightAnchor.constraint(equalToConstant: 40),
        headerOfMainView.widthAnchor.constraint(equalToConstant: 450),
        scrollView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
        scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
        scrollView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
        cityLabel.bottomAnchor.constraint(lessThanOrEqualTo: tempLabel.safeAreaLayoutGuide.bottomAnchor, constant: cityLabel.frame.height),
        cityLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 5),
        segmentedControl.centerYAnchor.constraint(equalTo: headerView.centerYAnchor, constant: 28),
        segmentedControl.centerXAnchor.constraint(equalTo: headerView.centerXAnchor, constant: 89),
        locationIcon.topAnchor.constraint(equalTo: location.topAnchor, constant: 10),
        locationIcon.leadingAnchor.constraint(equalTo: location.leadingAnchor, constant: -25),
        location.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
        location.centerYAnchor.constraint(equalTo: headerOfMainView.centerYAnchor, constant: -6),
        tempLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 5),
        tempLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 2),
        tempOriginal.leftAnchor.constraint(equalTo: secondView.safeAreaLayoutGuide.leftAnchor, constant: 20),
        tempOriginal.topAnchor.constraint(equalTo: secondView.safeAreaLayoutGuide.topAnchor, constant: 40),
        tempOriginal.rightAnchor.constraint(equalTo: secondView.rightAnchor, constant: -10),
        tempOriginal.bottomAnchor.constraint(equalTo: secondView.bottomAnchor, constant: -40),
        tempLabel.leftAnchor.constraint(equalTo: secondView.safeAreaLayoutGuide.leftAnchor, constant: 200),
        tempLabel.topAnchor.constraint(equalTo: secondView.safeAreaLayoutGuide.topAnchor, constant: 40),
        tempLabel.rightAnchor.constraint(equalTo: secondView.rightAnchor, constant: -50),
        tempLabel.bottomAnchor.constraint(equalTo: secondView.bottomAnchor, constant: -40),
        temp.leftAnchor.constraint(equalTo: secondView.safeAreaLayoutGuide.leftAnchor, constant: 20),
        temp.topAnchor.constraint(equalTo: secondView.safeAreaLayoutGuide.topAnchor, constant: 15),
        temp.rightAnchor.constraint(equalTo: secondView.rightAnchor, constant: -250),
        date.leftAnchor.constraint(equalTo: secondView.safeAreaLayoutGuide.leftAnchor, constant: 20),
        date.topAnchor.constraint(equalTo: temp.safeAreaLayoutGuide.bottomAnchor, constant: 5),
        date.rightAnchor.constraint(equalTo: secondView.rightAnchor, constant: -250),
        imageView.leftAnchor.constraint(equalTo: secondView.safeAreaLayoutGuide.leftAnchor, constant: 20),
        imageView.rightAnchor.constraint(equalTo: secondView.rightAnchor, constant: -330),
        imageView.topAnchor.constraint(equalTo: date.safeAreaLayoutGuide.topAnchor, constant: 120),
        imageView.bottomAnchor.constraint(equalTo: secondView.bottomAnchor, constant: -60)
        ])
    }
    
    func updateData(_ temp: String,_ city: String,_ value: String) {
        DispatchQueue.main.async {
            self.tempLabel.text = temp
            self.cityLabel.text = city
            self.location.setTitle(value, for: .normal)
        }
    }
}
