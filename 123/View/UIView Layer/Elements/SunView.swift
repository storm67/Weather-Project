//
//  SunView.swift
//  123
//
//  Created by Storm67 on 13/02/2021.
//  Copyright © 2021 gdml. All rights reserved.
//

import Foundation
import UIKit

protocol SunChanger: class {
    func sunChanger(_ sunrise: Int, _ sunset: Int)
}

class SunView: UIView {
    fileprivate var path = UIBezierPath()
    fileprivate let graph = UIView(frame: CGRect(x: 15, y: 125, width: 360, height: 1))
    static var endAngle: CGFloat?
    
    let firstTime: UILabel = {
        let firstTime = UILabel()
        firstTime.text = "07:00"
        firstTime.textColor = .orange
        firstTime.translatesAutoresizingMaskIntoConstraints = false
        firstTime.font = UIFont(name: "Verdana-Bold", size: 11)
        firstTime.textAlignment = .center
        return firstTime
    }()
    
    let secondTime: UILabel = {
        let secondTime = UILabel()
        secondTime.text = "16:00"
        secondTime.textColor = .orange
        secondTime.translatesAutoresizingMaskIntoConstraints = false
        secondTime.font = UIFont(name: "Verdana-Bold", size: 11)
        secondTime.textAlignment = .center
        return secondTime
    }()
    
    var circleFirst: Circle = {
           let circle = Circle(frame: .zero, strokeColor: .orange)
           circle.fillColor = .systemOrange
           circle.backgroundColor = .none
           circle.isOpaque = false
           circle.translatesAutoresizingMaskIntoConstraints = false
           return circle
    }()
    
    var circleSecond: Circle = {
           let circle = Circle(frame: .zero, strokeColor: .white)
           circle.float = 3
           circle.fillColor = .systemOrange
           circle.backgroundColor = .systemOrange
           circle.isOpaque = false
           circle.translatesAutoresizingMaskIntoConstraints = false
           return circle
    }()
    
    var imageView: UIImageView = {
           let image = UIImageView()
           image.image = UIImage(named: "1")
           image.translatesAutoresizingMaskIntoConstraints = false
           image.contentMode = .scaleAspectFit
           return image
       }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        graph.backgroundColor = .white
        addSubview(graph)
        addSubview(circleFirst)
        addSubview(circleSecond)
        addSubview(firstTime)
        addSubview(secondTime)
        addSubview(imageView)
        NSLayoutConstraint.activate([
        imageView.heightAnchor.constraint(equalToConstant: 20),
        imageView.widthAnchor.constraint(equalToConstant: 20),
        circleFirst.leftAnchor.constraint(equalTo: leftAnchor, constant: 93),
        circleFirst.topAnchor.constraint(equalTo: topAnchor, constant: 120),
        circleFirst.rightAnchor.constraint(equalTo: rightAnchor, constant: -297),
        circleFirst.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25),
        circleSecond.leftAnchor.constraint(equalTo: leftAnchor, constant: 295),
        circleSecond.topAnchor.constraint(equalTo: topAnchor, constant: 122),
        circleSecond.rightAnchor.constraint(equalTo: rightAnchor, constant: -96),
        circleSecond.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25),
        firstTime.leftAnchor.constraint(equalTo: leftAnchor, constant: 55),
        firstTime.topAnchor.constraint(equalTo: topAnchor, constant: 130),
        firstTime.rightAnchor.constraint(equalTo: rightAnchor, constant: -255),
        firstTime.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        secondTime.leftAnchor.constraint(equalTo: leftAnchor, constant: 278),
        secondTime.topAnchor.constraint(equalTo: topAnchor, constant: 130),
        secondTime.rightAnchor.constraint(equalTo: rightAnchor, constant: -75),
        secondTime.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
       }
    
     required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
       }
    
    override func draw(_ rect: CGRect) {
        state()
        setStroke()
        animator()
       }
    
    func state() -> UIBezierPath {
        let centre = CGPoint(x: bounds.size.width/2, y: 125)
        let path = UIBezierPath(arcCenter: centre, radius: 100.0, startAngle: .pi, endAngle: 2.0 * .pi, clockwise: true)
        let dashes: [ CGFloat ] = [ 4.0, 6.0 ]
        path.setLineDash(dashes, count: dashes.count, phase: 0.0)
        UIColor.white.setStroke()
        path.lineWidth = 2
        path.stroke()
        return path
    }
    
    func setStroke() -> UIBezierPath {
        guard let angle = SunView.endAngle else { return UIBezierPath() }
        let centre = CGPoint(x: bounds.size.width/2, y: 125)
        path = UIBezierPath(arcCenter: centre, radius: 100.0, startAngle: .pi, endAngle: angle, clockwise: true)
        let dashes: [ CGFloat ] = [ 4.0, 6.0 ]
        path.setLineDash(dashes, count: dashes.count, phase: 0.0)
        UIColor.orange.setStroke()
        path.lineWidth = 2
        path.stroke()
        return path
    }
    
    func animator() {
    let flightAnimation = CAKeyframeAnimation(keyPath: "position")
    flightAnimation.path = path.cgPath
    flightAnimation.speed = 0
    flightAnimation.timeOffset = 1.99
    flightAnimation.duration = 2
    imageView.layer.add(flightAnimation, forKey: "position")
    imageView.setNeedsDisplay()
    }

    
}
