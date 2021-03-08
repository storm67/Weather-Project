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
    
    fileprivate let back = BackgroundView()
    fileprivate var letters = [String.SubSequence]()
    fileprivate lazy var sunlightStatus = SunView()
    
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
        labelDate.font = UIFont(name: "UniSansHeavyCaps", size: 37)
        return labelDate
    }()
    
    var circle: Circle = {
        let circle = Circle(frame: .zero, strokeColor: .white)
        circle.fillColor = .white
        circle.isOpaque = false
        return circle
    }()
    
    var state: UILabel = {
        let state = UILabel()
        state.text = "Солнечно"
        state.textColor = .white
        state.translatesAutoresizingMaskIntoConstraints = false
        state.font = UIFont(name: "Verdana-Bold", size: 16)
        state.lineBreakMode = .byWordWrapping
        state.numberOfLines = 0
        return state
    }()
    
    var imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "1")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    var imageBackground: UIImageView = {
        let imageBackgr = UIImageView()
        imageBackgr.contentMode = .scaleAspectFill
        imageBackgr.layer.masksToBounds = true
        imageBackgr.layer.cornerRadius = 5
        imageBackgr.translatesAutoresizingMaskIntoConstraints = false
        return imageBackgr
    }()
    
    var tableView: UITableView = {
        var tableView = UITableView()
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 65, bottom: 0, right: 0)
        tableView.separatorColor = .none
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.rowHeight = 90.0
        tableView.register(CustomCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.cornerRadius = 5
        tableView.layer.masksToBounds = true
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
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
        label.text = "Осадки"
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
        label.text = "Влажность"
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
        label.text = "Ветер"
        label.font = UIFont(name: "UniSansHeavyCaps", size: 16)
        label.textColor = .white
        return label
    }()
    
    var nextScreen: GradientButton = {
        let button = GradientButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Описание", for: .normal)
        button.titleLabel?.font = UIFont(name: "Arial-BoldMT", size: 16)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    var windText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0 км/ч"
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textColor = .white
        return label
    }()
    
    var index: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "ИНДЕКС КАЧЕСТВА ВОЗДУХА"
        label.font = label.font.withSize(15)
        label.textColor = .white
        return label
    }()
    
    var indexNumber: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "48"
        label.font = UIFont(name: "UniSansThinCAPS", size: 49)
        label.textColor = .white
        return label
    }()
    
    var indexDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Хорошее"
        label.font = label.font.withSize(15)
        label.textColor = .white
        return label
    }()
    
    var indexFull: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Качество воздуха считается удовлетворительным"
        label.font = label.font.withSize(15)
        label.textColor = .white
        return label
    }()
    
    let day: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "15 Дек. 2020"
        label.textColor = .white
        label.font = UIFont(name: "AvenirNext-Regular", size: 15)
        return label
    }()
    
    let date: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Четверг"
        label.textColor = .white
        label.font = UIFont(name: "Verdana-Bold", size: 20)
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
        button.setTitle("", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let locationMask: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let headerView: UIView = {
        let view = UIView()
        return view
    }()
    
    let qualityText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Умеренное"
        label.textColor = .white
        label.font = UIFont(name: "GurmukhiMN", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionQuality: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Качество воздуха приемлемо"
        label.textColor = .white
        label.font = UIFont(name: "AvenirNext-Regular", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let secondView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 5
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
    
    let airIndicatorView: UIView = {
        let view = AirQualityView()
        view.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 5
        return view
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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
        scrollView.addSubview(headerView)
        scrollView.addSubview(airIndicatorView)
        scrollView.addSubview(secondView)
        scrollView.addSubview(tableView)
        scrollView.contentSize = CGSize(width:frame.size.width, height: 1355)
        secondView.addSubview(imageBackground)
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
        secondView.addSubview(nextScreen)
        scrollView.addSubview(locationIcon)
        headerOfMainView.addSubview(location)
        scrollView.addSubview(sunlightStatus)
        airIndicatorView.addSubview(index)
        airIndicatorView.addSubview(indexNumber)
        airIndicatorView.addSubview(qualityText)
        airIndicatorView.addSubview(descriptionQuality)
        circle.frame = CGRect(x: 0, y: 105, width: 15, height: 15)
        airIndicatorView.addSubview(circle)
        tableView.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        segmentedControl.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        headerView.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        NSLayoutConstraint.activate([
            sunlightStatus.topAnchor.constraint(equalTo: airIndicatorView.safeAreaLayoutGuide.bottomAnchor, constant: 25),
            sunlightStatus.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.95),
            sunlightStatus.heightAnchor.constraint(equalToConstant: 151),
            sunlightStatus.centerXAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.centerXAnchor),
            headerOfMainView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            headerOfMainView.centerXAnchor.constraint(equalTo: centerXAnchor),
            headerOfMainView.heightAnchor.constraint(equalToConstant: 80),
            headerOfMainView.widthAnchor.constraint(equalToConstant: 400),
            secondView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            secondView.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 40),
            secondView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.95),
            secondView.heightAnchor.constraint(equalToConstant: 270),
            precipitation.leftAnchor.constraint(equalTo: imageBackground.safeAreaLayoutGuide.rightAnchor, constant: 20),
            precipitation.topAnchor.constraint(equalTo: secondView.safeAreaLayoutGuide.topAnchor, constant: 20),
            precipitation.rightAnchor.constraint(equalTo: precipitationText.rightAnchor, constant: -90),
            precipitation.bottomAnchor.constraint(equalTo: humidity.bottomAnchor, constant: -25),
            precipitationText.topAnchor.constraint(equalTo: precipitation.topAnchor),
            precipitationText.rightAnchor.constraint(equalTo: secondView.safeAreaLayoutGuide.rightAnchor, constant: -20),
            precipitationText.bottomAnchor.constraint(equalTo: humidityText.bottomAnchor, constant: -25),
            humidity.leftAnchor.constraint(equalTo: imageBackground.safeAreaLayoutGuide.rightAnchor, constant: 20),
            humidity.rightAnchor.constraint(equalTo: secondView.rightAnchor, constant: -35),
            humidity.bottomAnchor.constraint(equalTo: wind.bottomAnchor, constant: -25),
            humidityText.rightAnchor.constraint(lessThanOrEqualTo: secondView.rightAnchor, constant: -20),
            humidityText.bottomAnchor.constraint(equalTo: windText.bottomAnchor, constant: -25),
            wind.leftAnchor.constraint(equalTo: imageBackground.safeAreaLayoutGuide.rightAnchor, constant: 20),
            wind.rightAnchor.constraint(equalTo: secondView.rightAnchor, constant: -35),
            wind.bottomAnchor.constraint(equalTo: secondView.bottomAnchor, constant: -180),
            windText.rightAnchor.constraint(lessThanOrEqualTo: secondView.safeAreaLayoutGuide.rightAnchor, constant: -20),
            windText.bottomAnchor.constraint(equalTo: secondView.bottomAnchor, constant: -180),
            tableView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            tableView.topAnchor.constraint(equalTo: secondView.safeAreaLayoutGuide.bottomAnchor, constant: 30),
            tableView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.95),
            tableView.heightAnchor.constraint(equalToConstant: 450),
            scrollView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            scrollView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            scrollView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            location.centerXAnchor.constraint(equalTo: headerOfMainView.centerXAnchor),
            location.topAnchor.constraint(equalTo: headerOfMainView.safeAreaLayoutGuide.topAnchor, constant: -5),
            location.bottomAnchor.constraint(equalTo: headerOfMainView.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            tempOriginal.leftAnchor.constraint(equalTo: imageBackground.safeAreaLayoutGuide.leftAnchor, constant: 20),
            tempOriginal.rightAnchor.constraint(equalTo: imageBackground.rightAnchor, constant: -50),
            tempOriginal.bottomAnchor.constraint(equalTo: state.topAnchor, constant: 0),
            collection.leftAnchor.constraint(equalTo: imageBackground.safeAreaLayoutGuide.rightAnchor, constant: 20),
            collection.topAnchor.constraint(equalTo: wind.safeAreaLayoutGuide.bottomAnchor, constant: 35),
            collection.rightAnchor.constraint(equalTo: secondView.rightAnchor, constant: -15),
            collection.bottomAnchor.constraint(equalTo: secondView.bottomAnchor, constant: -55),
            nextScreen.leftAnchor.constraint(equalTo: imageBackground.safeAreaLayoutGuide.rightAnchor, constant: 20),
            nextScreen.topAnchor.constraint(equalTo: collection.safeAreaLayoutGuide.bottomAnchor, constant: 15),
            nextScreen.rightAnchor.constraint(equalTo: secondView.rightAnchor, constant: -15),
            nextScreen.bottomAnchor.constraint(equalTo: secondView.bottomAnchor, constant: -10),
            day.leftAnchor.constraint(equalTo: imageBackground.safeAreaLayoutGuide.leftAnchor, constant: 20),
            day.topAnchor.constraint(equalTo: imageBackground.safeAreaLayoutGuide.topAnchor, constant: 10),
            day.rightAnchor.constraint(equalTo: imageBackground.rightAnchor, constant: -50),
            date.leftAnchor.constraint(equalTo: imageBackground.safeAreaLayoutGuide.leftAnchor, constant: 20),
            date.topAnchor.constraint(equalTo: day.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            date.rightAnchor.constraint(equalTo: imageBackground.rightAnchor, constant: -50),
            imageView.leftAnchor.constraint(equalTo: imageBackground.safeAreaLayoutGuide.leftAnchor, constant: 0),
            imageView.rightAnchor.constraint(equalTo: imageBackground.rightAnchor, constant: -85),
            imageView.topAnchor.constraint(lessThanOrEqualTo: date.safeAreaLayoutGuide.bottomAnchor, constant: 90),
            imageView.bottomAnchor.constraint(equalTo: tempOriginal.safeAreaLayoutGuide.topAnchor, constant: 0),
            imageView.heightAnchor.constraint(equalToConstant: 40),
            state.leftAnchor.constraint(equalTo: imageBackground.safeAreaLayoutGuide.leftAnchor, constant: 20),
            state.rightAnchor.constraint(equalTo: imageBackground.rightAnchor, constant: -40),
            state.bottomAnchor.constraint(greaterThanOrEqualTo: imageBackground.bottomAnchor, constant: -15),
            imageBackground.leftAnchor.constraint(equalTo: secondView.safeAreaLayoutGuide.leftAnchor),
            imageBackground.topAnchor.constraint(equalTo: secondView.topAnchor, constant: 0),
            imageBackground.rightAnchor.constraint(equalTo: wind.rightAnchor, constant: -180),
            imageBackground.bottomAnchor.constraint(equalTo: secondView.bottomAnchor, constant: 0),
            airIndicatorView.topAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.bottomAnchor, constant: 25),
            airIndicatorView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.95),
            airIndicatorView.heightAnchor.constraint(equalToConstant: 151),
            airIndicatorView.centerXAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.centerXAnchor),
            index.topAnchor.constraint(lessThanOrEqualTo: airIndicatorView.safeAreaLayoutGuide.topAnchor, constant: 8),
            index.leftAnchor.constraint(equalTo: airIndicatorView.safeAreaLayoutGuide.leftAnchor, constant: 14),
            indexNumber.leftAnchor.constraint(equalTo: airIndicatorView.safeAreaLayoutGuide.leftAnchor, constant: 14),
            indexNumber.topAnchor.constraint(equalTo: airIndicatorView.safeAreaLayoutGuide.topAnchor, constant: 35),
            indexNumber.bottomAnchor.constraint(equalTo: airIndicatorView.bottomAnchor, constant: -45),
            qualityText.leftAnchor.constraint(lessThanOrEqualTo: indexNumber.safeAreaLayoutGuide.rightAnchor, constant: 10),
            qualityText.topAnchor.constraint(equalTo: airIndicatorView.safeAreaLayoutGuide.topAnchor, constant: 18),
            qualityText.rightAnchor.constraint(greaterThanOrEqualTo: airIndicatorView.rightAnchor, constant: -107),
            qualityText.bottomAnchor.constraint(equalTo: airIndicatorView.bottomAnchor, constant: -60),
            descriptionQuality.leftAnchor.constraint(equalTo: indexNumber.safeAreaLayoutGuide.rightAnchor, constant: 10),
            descriptionQuality.topAnchor.constraint(equalTo: airIndicatorView.safeAreaLayoutGuide.topAnchor, constant: 58),
            descriptionQuality.rightAnchor.constraint(greaterThanOrEqualTo: airIndicatorView.rightAnchor, constant: -107),
            descriptionQuality.bottomAnchor.constraint(equalTo: airIndicatorView.bottomAnchor, constant: -60),
        ])
    }
    
    
    func updateData(_ state: String,_ city: String,_ value: String,_ image: UIImage,_ air: Int,_ index: Int,_ indexMain: Int,_ sun: CGFloat, _ sunrise: Int, _ sunset: Int, _ timeZone: Int) {
        self.letters = state.split { !$0.isLetter }
        print(letters)
        DispatchQueue.main.async {
            if self.letters.count == 1 {
                self.state.text = "\(self.letters[0])"
            } else if self.letters.count >= 2 {
                self.state.text = "\(self.letters[0]) \(self.letters[1])"
            }; if self.letters.contains("Преимущественно") {
                self.state.text = "\(self.letters[1].capitalized)"
            }
            self.location.setTitle(value, for: .normal)
            self.imageBackground.image = image
            self.indexNumber.text = "\(index)"
            self.tempOriginal.text = "\(indexMain)°"
            self.circle.frame = CGRect(x: 0 + index, y: 105, width: 15, height: 15)
            self.indexNumber.textColor = UIColor().switcher(index)
            self.imageView.image = self.back.switchImage(self.imageView, state)
            self.imageView.sizeToFit()
            self.sunlightStatus.setNeedsDisplay()
            self.sunlightStatus.firstTime.text = "\(sunrise.returnTime(time: timeZone))"
            self.sunlightStatus.secondTime.text = "\(sunset.returnTime(time: timeZone))"
            self.setUp(sunrise, sunset, timeZone)
        }
    }
    
    func setUp(_ f: Int, _ s: Int, _ timeZone: Int) {
        let angle: CGFloat = 0.031
        let now = Int.now(timeOffset: timeZone)
        let start = f.convertToHours(time: timeZone)
        let finish = s.convertToHours(time: timeZone)
        let value = 3.1 - ((CGFloat(now) / CGFloat(finish)) * 100) * angle
        let less = now < start ? true : false
        let more = now > finish ? true : false
        if less {
            sunlightStatus.endAngle = -3.1
        } else {
            sunlightStatus.endAngle = -value
        }
        if more {
            sunlightStatus.endAngle = 0
        }
    }
}
