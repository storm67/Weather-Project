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
        labelDate.text = "29°C"
        labelDate.textColor = .white
        labelDate.translatesAutoresizingMaskIntoConstraints = false
        labelDate.font = UIFont(name: "UniSansHeavyCaps", size: 35)
        return labelDate
    }()
    
    var state: UILabel = {
        let state = UILabel()
        state.text = "Sunny"
        state.textColor = .white
        state.translatesAutoresizingMaskIntoConstraints = false
        state.font = UIFont(name: "Verdana-Bold", size: 16)
        return state
    }()
    
    var imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "1")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var imageBackgr: UIImageView = {
        let imageBackgr = UIImageView()
        imageBackgr.contentMode = .scaleAspectFill
        imageBackgr.layer.masksToBounds = true
        imageBackgr.layer.cornerRadius = 15
        imageBackgr.translatesAutoresizingMaskIntoConstraints = false
        return imageBackgr
    }()
    
    var tableView: UITableView = {
        var myTableView = UITableView()
        myTableView.separatorColor = .white
        myTableView.tableFooterView = UIView(frame: .zero)
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
    
    var collection: UICollectionView = {
        let collection = UICollectionView()
        collection.backgroundColor = .orange
        collection.layer.cornerRadius = 5
        collection.layer.masksToBounds = true
        collection.isScrollEnabled = false
        collection.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    var precipitation: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Precipitation"
        label.font = UIFont(name: "UniSansHeavyCaps", size: 16)
        label.textColor = .white
        return label
    }()
    
    var precipitationText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0%"
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textColor = .white
        return label
    }()
    
    var humidity: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Humidity"
        label.font = UIFont(name: "UniSansHeavyCaps", size: 16)
        label.textColor = .white
        return label
    }()
    
    var humidityText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "34%"
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textColor = .white
        return label
    }()
    
    var wind: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Wind"
        label.font = UIFont(name: "UniSansHeavyCaps", size: 16)
        label.textColor = .white
        return label
    }()
    
    var windText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0 km/h"
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textColor = .white
        return label
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
    
    let day: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tuesday"
        label.textColor = .white
        label.font = UIFont(name: "Verdana-Bold", size: 20)
        return label
    }()
    
    let date: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "15 Dec 2020"
        label.textColor = .white
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
        return view
    }()
    
    let secondView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
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
        secondView.addSubview(imageBackgr)
        secondView.addSubview(imageView)
        secondView.addSubview(tempOriginal)
        secondView.addSubview(day)
        secondView.addSubview(state)
        secondView.addSubview(precipitationText)
        secondView.addSubview(date)
        secondView.addSubview(precipitation)
        secondView.addSubview(humidity)
        secondView.addSubview(humidityText)
        secondView.addSubview(wind)
        secondView.addSubview(windText)
        secondView.addSubview(collection)
        headerOfMainView.addSubview(locationIcon)
        headerOfMainView.addSubview(location)
        tableView.backgroundColor = UIColor(hexFromString: "#00004d")
        segmentedControl.backgroundColor = UIColor(hexFromString: "#00004d")
        headerView.backgroundColor = UIColor(hexFromString: "#00004d")
        NSLayoutConstraint.activate([
        secondView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
        secondView.topAnchor.constraint(equalTo: headerOfMainView.safeAreaLayoutGuide.bottomAnchor, constant: 10),
        secondView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.95),
        secondView.heightAnchor.constraint(equalToConstant: 270),
        precipitation.leftAnchor.constraint(equalTo: imageBackgr.safeAreaLayoutGuide.rightAnchor, constant: 20),
        precipitation.topAnchor.constraint(equalTo: secondView.safeAreaLayoutGuide.topAnchor, constant: 0),
        precipitation.rightAnchor.constraint(equalTo: secondView.rightAnchor, constant: -35),
        precipitation.bottomAnchor.constraint(equalTo: secondView.bottomAnchor, constant: -170),
        precipitationText.leftAnchor.constraint(equalTo: imageBackgr.safeAreaLayoutGuide.rightAnchor, constant: 170),
        precipitationText.topAnchor.constraint(equalTo: secondView.safeAreaLayoutGuide.topAnchor, constant: 0),
        precipitationText.rightAnchor.constraint(equalTo: secondView.rightAnchor, constant: -15),
        precipitationText.bottomAnchor.constraint(equalTo: secondView.bottomAnchor, constant: -170),
        humidity.leftAnchor.constraint(equalTo: imageBackgr.safeAreaLayoutGuide.rightAnchor, constant: 20),
        humidity.topAnchor.constraint(equalTo: precipitation.safeAreaLayoutGuide.topAnchor, constant: 0),
        humidity.rightAnchor.constraint(equalTo: secondView.rightAnchor, constant: -35),
        humidity.bottomAnchor.constraint(equalTo: secondView.bottomAnchor, constant: -115),
        humidityText.leftAnchor.constraint(equalTo: imageBackgr.safeAreaLayoutGuide.rightAnchor, constant: 170),
        humidityText.topAnchor.constraint(equalTo: precipitationText.safeAreaLayoutGuide.topAnchor, constant: -53),
        humidityText.rightAnchor.constraint(lessThanOrEqualTo: secondView.rightAnchor, constant: -15),
        humidityText.bottomAnchor.constraint(equalTo: secondView.bottomAnchor, constant: -60),
        wind.leftAnchor.constraint(equalTo: imageBackgr.safeAreaLayoutGuide.rightAnchor, constant: 20),
        wind.topAnchor.constraint(equalTo: humidity.safeAreaLayoutGuide.topAnchor, constant: -10),
        wind.rightAnchor.constraint(equalTo: secondView.rightAnchor, constant: -35),
        wind.bottomAnchor.constraint(equalTo: secondView.bottomAnchor, constant: -50),
        windText.leftAnchor.constraint(equalTo: imageBackgr.safeAreaLayoutGuide.rightAnchor, constant: 152),
        windText.topAnchor.constraint(equalTo: humidity.safeAreaLayoutGuide.topAnchor, constant: -20),
        windText.rightAnchor.constraint(lessThanOrEqualTo: secondView.rightAnchor, constant: 0),
        windText.bottomAnchor.constraint(equalTo: secondView.bottomAnchor, constant: -40),
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
        tempOriginal.topAnchor.constraint(equalTo: imageView.safeAreaLayoutGuide.bottomAnchor, constant: 10),
        tempOriginal.rightAnchor.constraint(equalTo: secondView.rightAnchor, constant: -250),
        tempOriginal.bottomAnchor.constraint(equalTo: secondView.bottomAnchor, constant: -30),
        tempLabel.leftAnchor.constraint(equalTo: secondView.safeAreaLayoutGuide.leftAnchor, constant: 200),
        tempLabel.topAnchor.constraint(equalTo: secondView.safeAreaLayoutGuide.topAnchor, constant: 40),
        tempLabel.rightAnchor.constraint(equalTo: secondView.rightAnchor, constant: -50),
        tempLabel.bottomAnchor.constraint(equalTo: secondView.bottomAnchor, constant: -40),
        collection.leftAnchor.constraint(equalTo: secondView.safeAreaLayoutGuide.leftAnchor, constant: 200),
        collection.topAnchor.constraint(equalTo: secondView.safeAreaLayoutGuide.topAnchor, constant: 40),
        collection.rightAnchor.constraint(equalTo: secondView.rightAnchor, constant: -50),
        collection.bottomAnchor.constraint(equalTo: secondView.bottomAnchor, constant: -40),
        day.leftAnchor.constraint(equalTo: secondView.safeAreaLayoutGuide.leftAnchor, constant: 20),
        day.topAnchor.constraint(equalTo: secondView.safeAreaLayoutGuide.topAnchor, constant: 10),
        day.rightAnchor.constraint(equalTo: secondView.rightAnchor, constant: -250),
        date.leftAnchor.constraint(equalTo: secondView.safeAreaLayoutGuide.leftAnchor, constant: 20),
        date.topAnchor.constraint(lessThanOrEqualTo: day.safeAreaLayoutGuide.bottomAnchor, constant: 10),
        date.rightAnchor.constraint(equalTo: secondView.rightAnchor, constant: -250),
        imageView.leftAnchor.constraint(equalTo: secondView.safeAreaLayoutGuide.leftAnchor, constant: 20),
        imageView.rightAnchor.constraint(equalTo: secondView.rightAnchor, constant: -330),
        imageView.topAnchor.constraint(lessThanOrEqualTo: date.safeAreaLayoutGuide.topAnchor, constant: 110),
        imageView.bottomAnchor.constraint(equalTo: secondView.bottomAnchor, constant: -85),
        imageView.widthAnchor.constraint(equalToConstant: 25),
        imageView.heightAnchor.constraint(equalToConstant: 40),
        state.leftAnchor.constraint(equalTo: secondView.safeAreaLayoutGuide.leftAnchor, constant: 20),
        state.topAnchor.constraint(lessThanOrEqualTo: tempOriginal.safeAreaLayoutGuide.bottomAnchor, constant: 0),
        state.rightAnchor.constraint(equalTo: secondView.rightAnchor, constant: -250),
        state.bottomAnchor.constraint(equalTo: secondView.bottomAnchor, constant: -10),
        imageBackgr.leftAnchor.constraint(equalTo: secondView.leftAnchor, constant: 0),
        imageBackgr.topAnchor.constraint(equalTo: secondView.topAnchor, constant: 0),
        imageBackgr.rightAnchor.constraint(equalTo: secondView.rightAnchor, constant: -220),
        imageView.widthAnchor.constraint(equalToConstant: 155),
        imageBackgr.bottomAnchor.constraint(equalTo: secondView.bottomAnchor, constant: 0)
        ])
    }
    
    
    func updateData(_ temp: String,_ city: String,_ value: String, _ image: UIImage) {
        DispatchQueue.main.async {
            self.tempLabel.text = temp
            self.cityLabel.text = city
            self.location.setTitle(value, for: .normal)
            self.imageBackgr.image = image
        }
    }
}
