//
//  GeneralView.swift
//  123
//
//  Created by gdml on 30/04/2020.
//  Copyright © 2020 gdml. All rights reserved.
//
import UIKit

final class MainControllerView: UIView {
    
    fileprivate var letters = [String.SubSequence]()
    lazy var sunlightStatus = SunView()
    fileprivate var color: UIColor = .black
    
    var tempOriginal: UILabel = {
        let labelDate = UILabel()
        labelDate.text = "29°C"
        labelDate.textColor = .white
        labelDate.translatesAutoresizingMaskIntoConstraints = false
        labelDate.font = UIFont(name: "UniSansHeavyCaps", size: 70)
        labelDate.textAlignment = .right
        return labelDate
    }()
    
    var circle: Circle = {
        let circle = Circle(frame: .zero, strokeColor: .white)
        circle.fillColor = .black
        circle.isOpaque = false
        return circle
    }()
    
    var state: UILabel = {
        let state = UILabel()
        state.text = "Солнечно"
        state.textColor = .white
        state.translatesAutoresizingMaskIntoConstraints = false
        state.font = UIFont(name: "Verdana-Bold", size: 20)
        state.lineBreakMode = .byWordWrapping
        state.numberOfLines = 0
        return state
    }()
    
    var charts: LineChart = {
        let charts = LineChart()
        charts.isCurved = true
        charts.translatesAutoresizingMaskIntoConstraints = false
        charts.backgroundColor = #colorLiteral(red: 0.9043619633, green: 0.9659909606, blue: 0.9911366105, alpha: 1)
        charts.layer.masksToBounds = true
        charts.layer.cornerRadius = 5
        return charts
    }()
    
    var tableView: UITableView = {
        var tableView = UITableView()
        tableView.backgroundColor = #colorLiteral(red: 0.9043619633, green: 0.9659909606, blue: 0.9911366105, alpha: 1)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 65, bottom: 0, right: 0)
        tableView.separatorColor = .white
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.rowHeight = 75.0
        tableView.register(CustomCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.cornerRadius = 5
        tableView.layer.masksToBounds = true
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    var index: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "ИНДЕКС КАЧЕСТВА ВОЗДУХА"
        label.font = label.font.withSize(15)
        label.textColor = .black
        return label
    }()
    
    var indexNumber: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "48"
        label.font = UIFont(name: "UniSansThinCAPS", size: 49)
        label.textColor = .black
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
        label.textColor = .black
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
        label.text = "Ощущается как 5°"
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont(name: "Verdana-Bold", size: 10)
        return label
    }()
    
    let today: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Сегодня"
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont(name: "Verdana-Bold", size: 10)
        return label
    }()
    
    let fiveDay: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Следующие 5 дней"
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont(name: "Verdana-Bold", size: 10)
        return label
    }()
    
    let header: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9007774591, green: 0.9009286165, blue: 0.9007576108, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var weatherStatusImage: UIImageView = {
        let weatherStatusImage = UIImageView()
        weatherStatusImage.contentMode = .scaleAspectFill
        weatherStatusImage.layer.masksToBounds = true
        weatherStatusImage.layer.cornerRadius = 5
        weatherStatusImage.translatesAutoresizingMaskIntoConstraints = false
        return weatherStatusImage
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
        button.tag = 0
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
    
    let qualityText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Умеренное"
        label.textColor = .black
        label.font = UIFont(name: "GurmukhiMN", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionQuality: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Качество воздуха приемлемо"
        label.textColor = .black
        label.font = UIFont(name: "AvenirNext-Regular", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let secondView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.2954928279, green: 0.4419879317, blue: 0.8865286708, alpha: 1)
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
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let fiveDaysWeather: StatsView = {
        let view = StatsView()
        view.backgroundColor = #colorLiteral(red: 0.9043619633, green: 0.9659909606, blue: 0.9911366105, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()
    
    let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        return segmentedControl
    }()
    
    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.bounces = false
        v.isScrollEnabled = true
        v.bouncesZoom = false
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = #colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 1)
        return v
    }()
    
    let airIndicatorView: UIView = {
        let view = AirQualityView()
        view.backgroundColor = #colorLiteral(red: 0.9043619633, green: 0.9659909606, blue: 0.9911366105, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    func layout() {
        addSubview(scrollView)
        addSubview(headerOfMainView)
        scrollView.addSubview(tempOriginal)
        scrollView.addSubview(airIndicatorView)
        scrollView.addSubview(secondView)
        scrollView.addSubview(tableView)
        scrollView.addSubview(fiveDaysWeather)
        scrollView.contentSize = CGSize(width:frame.size.width, height: 1700)
        secondView.addSubview(tempOriginal)
        secondView.addSubview(day)
        secondView.addSubview(state)
        secondView.addSubview(weatherStatusImage)
        secondView.addSubview(date)
        scrollView.addSubview(charts)
        headerOfMainView.addSubview(location)
        scrollView.addSubview(sunlightStatus)
        airIndicatorView.addSubview(index)
        airIndicatorView.addSubview(indexNumber)
        airIndicatorView.addSubview(qualityText)
        airIndicatorView.addSubview(descriptionQuality)
        circle.frame = CGRect(x: 0, y: 105, width: 12, height: 12)
        airIndicatorView.addSubview(circle)
        weatherStatusImage.image = UIImage(named: "test")
        NSLayoutConstraint.activate([
            sunlightStatus.topAnchor.constraint(equalTo: airIndicatorView.bottomAnchor, constant: 20),
            sunlightStatus.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -25),
            sunlightStatus.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.95),
            sunlightStatus.heightAnchor.constraint(equalToConstant: 130),
            sunlightStatus.centerXAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.centerXAnchor),
            headerOfMainView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            headerOfMainView.centerXAnchor.constraint(equalTo: centerXAnchor),
            headerOfMainView.heightAnchor.constraint(equalToConstant: 80),
            headerOfMainView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            secondView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            secondView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 60),
            secondView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.95),
            secondView.heightAnchor.constraint(equalToConstant: 190),
            fiveDaysWeather.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            fiveDaysWeather.topAnchor.constraint(equalTo: secondView.bottomAnchor, constant: 25),
            fiveDaysWeather.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.95),
            fiveDaysWeather.heightAnchor.constraint(equalToConstant: 90),
            weatherStatusImage.leftAnchor.constraint(equalTo: secondView.leftAnchor, constant: 25),
            weatherStatusImage.topAnchor.constraint(equalTo: secondView.topAnchor, constant: 25),
            weatherStatusImage.rightAnchor.constraint(equalTo: secondView.rightAnchor, constant: -300),
            weatherStatusImage.bottomAnchor.constraint(equalTo: secondView.bottomAnchor, constant: -105),
            state.leftAnchor.constraint(equalTo: secondView.safeAreaLayoutGuide.leftAnchor, constant: 20),
            state.topAnchor.constraint(equalTo: secondView.safeAreaLayoutGuide.topAnchor, constant: 125),
            state.rightAnchor.constraint(equalTo: secondView.rightAnchor, constant: -50),
            date.leftAnchor.constraint(equalTo: secondView.safeAreaLayoutGuide.leftAnchor, constant: 260),
            date.topAnchor.constraint(equalTo: tempOriginal.safeAreaLayoutGuide.bottomAnchor, constant: 5),
            date.rightAnchor.constraint(equalTo: secondView.rightAnchor, constant: -20),
            tempOriginal.topAnchor.constraint(equalTo: secondView.topAnchor, constant: 25),
            tempOriginal.leftAnchor.constraint(lessThanOrEqualTo: weatherStatusImage.safeAreaLayoutGuide.rightAnchor, constant: 150),
            tempOriginal.rightAnchor.constraint(equalTo: secondView.rightAnchor, constant: -30),
            tempOriginal.bottomAnchor.constraint(equalTo: secondView.bottomAnchor, constant: -105),
            day.leftAnchor.constraint(equalTo: secondView.safeAreaLayoutGuide.leftAnchor, constant: 20),
            day.rightAnchor.constraint(equalTo: secondView.rightAnchor, constant: -40),
            day.bottomAnchor.constraint(equalTo: secondView.bottomAnchor, constant: -15),
            charts.topAnchor.constraint(equalTo: fiveDaysWeather.bottomAnchor, constant: 35),
            charts.heightAnchor.constraint(equalToConstant: 200),
            charts.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.95),
            charts.centerXAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.centerXAnchor),
            tableView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            tableView.topAnchor.constraint(equalTo: charts.bottomAnchor, constant: 30),
            tableView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.95),
            tableView.heightAnchor.constraint(equalToConstant: 370),
            scrollView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            scrollView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            scrollView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            location.centerXAnchor.constraint(equalTo: headerOfMainView.centerXAnchor),
            location.bottomAnchor.constraint(equalTo: headerOfMainView.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            airIndicatorView.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 30),
            airIndicatorView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.95),
            airIndicatorView.heightAnchor.constraint(equalToConstant: 151),
            airIndicatorView.centerXAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.centerXAnchor),
            index.topAnchor.constraint(equalTo: airIndicatorView.safeAreaLayoutGuide.topAnchor, constant: 10),
            index.leftAnchor.constraint(equalTo: airIndicatorView.safeAreaLayoutGuide.leftAnchor, constant: 14),
            indexNumber.leftAnchor.constraint(equalTo: airIndicatorView.safeAreaLayoutGuide.leftAnchor, constant: 14),
            indexNumber.topAnchor.constraint(equalTo: airIndicatorView.safeAreaLayoutGuide.topAnchor, constant: 35),
            indexNumber.bottomAnchor.constraint(equalTo: airIndicatorView.bottomAnchor, constant: -45),
            qualityText.leftAnchor.constraint(equalTo: indexNumber.safeAreaLayoutGuide.rightAnchor, constant: 10),
            qualityText.topAnchor.constraint(equalTo: index.safeAreaLayoutGuide.bottomAnchor, constant: 20),
            qualityText.rightAnchor.constraint(greaterThanOrEqualTo: airIndicatorView.rightAnchor, constant: -240),
            qualityText.bottomAnchor.constraint(equalTo: descriptionQuality.topAnchor, constant: 0),
            descriptionQuality.leftAnchor.constraint(equalTo: indexNumber.safeAreaLayoutGuide.rightAnchor, constant: 10),
            descriptionQuality.rightAnchor.constraint(greaterThanOrEqualTo: airIndicatorView.rightAnchor, constant: -107),
            descriptionQuality.bottomAnchor.constraint(equalTo: airIndicatorView.bottomAnchor, constant: -65),
        ])
    }
    
    func hasUnloaded() {
        scrollView.subviews.forEach {
            if $0 == sunlightStatus && $0 == secondView && $0 == airIndicatorView && $0 == scrollView && $0 == charts && $0 == tableView && $0 == fiveDaysWeather {
            print($0)
            $0.subviews.forEach {  $0.layer.opacity = 0 }
            } else {
            scrollView.showsVerticalScrollIndicator = false
            $0.subviews.forEach { $0.layer.opacity = 0 }
            let loader = Loader()
            loader.translatesAutoresizingMaskIntoConstraints = false
            $0.addSubview(loader)
            NSLayoutConstraint.activate([
                loader.topAnchor.constraint(equalTo: $0.topAnchor, constant: $0.bounds.midY),
                loader.leadingAnchor.constraint(equalTo: $0.leadingAnchor, constant: $0.bounds.midX)
            ])
            }
        }
    }
    
    func hasLoaded() {
        sunlightStatus.state()
    }
    
    
    func updateData(_ state: String,_ city: String,_ value: String,_ air: Int,_ index: Int,_ indexMain: Int, _ sunrise: Int, _ sunset: Int, _ timeZone: Int,_ wind: Int,_ pressure: Int,_ humidity: Int,_ direction: String) {
        self.letters = state.split { !$0.isLetter }
        DispatchQueue.main.async {
            if self.letters.count == 1 {
                self.state.text = "\(self.letters[0])"
            } else if self.letters.count >= 2 {
                self.state.text = "\(self.letters[0]) \(self.letters[1])"
            }; if self.letters.contains("Преимущественно") {
                self.state.text = "\(self.letters[1].capitalized)"
            }
            self.location.setTitle(value, for: .normal)
            self.indexNumber.text = "\(index)"
            self.tempOriginal.text = "\(indexMain)°"
            self.circle.frame = CGRect(x: 0 + index, y: 108, width: 12, height: 12)
            self.indexNumber.textColor = UIColor().switcher(index)
            self.sunlightStatus.setNeedsDisplay()
            self.sunlightStatus.firstTime.text = "Восход \(sunrise.returnTime(time: timeZone, interval: .since1970))"
            self.sunlightStatus.secondTime.text = "Закат \(sunset.returnTime(time: timeZone, interval: .since1970))"
            self.setUp(sunrise, sunset, timeZone)
            self.fiveDaysWeather.update(wind: wind, direction: direction, pressure: pressure, humidity: humidity)
        }
    }
    
    func chartsIntegrator(_ array: [DailyForecast]) {
    DispatchQueue.main.async {
    self.charts.dataEntries = array.map { PointEntry(value: $0.temperature, label: $0.dayIconPhrase) }
        }
    }
   
    
    func setUp(_ f: Int, _ s: Int, _ timeZone: Int) {
        let now = Int.now(timeOffset: timeZone)
        let start = f.convertToHours(time: timeZone)
        let finish = s.convertToHours(time: timeZone)
        let value: Double = Double((now * 100 / finish)) / 100
        let less = now < start ? true : false
        let more = now > finish ? true : false
        sunlightStatus.endAngle = CGFloat(value)
        if less || more {
        if less {
        sunlightStatus.endAngle = 0
        } else {
        sunlightStatus.endAngle = 1
        }
        }
    }
    
    func startAnimating() {
        for view in subviews {
            view.isSkeletonable = true
            view.showGradientSkeleton()
        }
    }
    
    func stopAnimating() {
        for view in subviews {
            view.isSkeletonable = true
            view.hideSkeleton()
        }
    }
    
}
