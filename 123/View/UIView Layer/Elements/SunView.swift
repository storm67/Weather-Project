//
//  SunView.swift
//  123
//
//  Created by Storm67 on 13/02/2021.
//  Copyright © 2021 gdml. All rights reserved.
//

import Foundation
import UIKit

class SunView: UIView {
    
    fileprivate var path: QuadBezier!
    var endAngle: CGFloat?
    
    let firstTime: UILabel = {
        let firstTime = UILabel()
        firstTime.text = "07:00"
        firstTime.textColor = .systemOrange
        firstTime.translatesAutoresizingMaskIntoConstraints = false
        firstTime.font = UIFont(name: "Verdana-Bold", size: 9)
        firstTime.textAlignment = .center
        return firstTime
    }()
    
    let secondTime: UILabel = {
        let secondTime = UILabel()
        secondTime.text = "16:00"
        secondTime.textColor = .systemOrange
        secondTime.translatesAutoresizingMaskIntoConstraints = false
        secondTime.font = UIFont(name: "Verdana-Bold", size: 9)
        secondTime.textAlignment = .center
        return secondTime
    }()
    
    let sunView: UILabel = {
        let sunView = UILabel()
        sunView.text = "СОЛНЦЕ"
        sunView.textColor = .black
        sunView.translatesAutoresizingMaskIntoConstraints = false
        sunView.font = sunView.font.withSize(15)
        sunView.textAlignment = .center
        return sunView
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
        addSubview(sunView)
        addSubview(firstTime)
        addSubview(secondTime)
        addSubview(imageView)
        NSLayoutConstraint.activate([
            sunView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            sunView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            imageView.heightAnchor.constraint(equalToConstant: 20),
            imageView.widthAnchor.constraint(equalToConstant: 20),
            firstTime.leftAnchor.constraint(equalTo: leftAnchor, constant: 70),
            firstTime.topAnchor.constraint(equalTo: topAnchor, constant: 95),
            firstTime.rightAnchor.constraint(equalTo: secondTime.rightAnchor, constant: -195),
            firstTime.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            secondTime.topAnchor.constraint(equalTo: topAnchor, constant: 95),
            secondTime.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        layer.masksToBounds = true
        layer.cornerRadius = 5
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    let pathLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineWidth = 2
        layer.strokeColor = UIColor.orange.cgColor
        layer.fillColor = UIColor.clear.cgColor
        return layer
    }()
    
    let maskLayer: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = UIColor.black.cgColor
        return layer
    }()
    
    override func draw(_ rect: CGRect) {
        path = setStroke()
        guard let path = path else { return }
        pathLayer.path = path.path.cgPath
        pathLayer.mask = maskLayer
        state()
        layer.addSublayer(pathLayer)
        //animator()
        imageView.center = path.point(at: 0.5)
        updateMask(at: imageView.center)
    }
    
    
    func updateMask(at point: CGPoint) {
        var f = bounds
        f.size.width = point.x
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        maskLayer.frame = f
        CATransaction.commit()
    }
    
    func state() -> UIBezierPath {
        let path = UIBezierPath()
        let p0 = CGPoint(x: 55, y: 95)
        let p2 = CGPoint(x: frame.size.width/2, y: 0)
        let p1 = CGPoint(x: frame.size.width/1.15, y: 95)
        path.move(to: p1)
        path.addQuadCurve(to: p0, controlPoint: p2)
        let dashes: [CGFloat] = [4.0, 6.0]
        path.setLineDash(dashes, count: dashes.count, phase: 0.0)
        UIColor.black.setStroke()
        path.lineWidth = 2
        path.stroke()
        return path
    }
    
    func setStroke() -> QuadBezier? {
        let p0 = CGPoint(x: 55, y: 95)
        let p2 = CGPoint(x: frame.size.width/2, y: 0)
        let p1 = CGPoint(x: frame.size.width/1.15, y: 95)
        let pather = QuadBezier(point1: p0, point2: p1, controlPoint: p2)
        return pather
    }
    
    func animator() {
        let flightAnimation = CAKeyframeAnimation(keyPath: "position")
        flightAnimation.path = path.path.cgPath
        flightAnimation.speed = 0
        flightAnimation.timeOffset = 0
        flightAnimation.duration = 0.1
        flightAnimation.isRemovedOnCompletion = false
        imageView.layer.add(flightAnimation, forKey: "position")
        imageView.setNeedsDisplay()
    }
    
    
    
}

struct QuadBezier {
    var point1: CGPoint
    var point2: CGPoint
    var controlPoint: CGPoint
    
    var path: UIBezierPath {
        let path = UIBezierPath()
        path.move(to: point1)
        path.addQuadCurve(to: point2, controlPoint: controlPoint)
        return path
    }
    
    func point(at t: CGFloat) -> CGPoint {
        let t1 = 1 - t
        //let tt = pow(1 - t1, 2) * point1.x + 2 * t1 * (1 - t1) * controlPoint.x + pow(t1,2) * point2.x
        return CGPoint(
            x: t1 * t1 * point1.x + 2 * t * t1 * controlPoint.x + t * t * point2.x,
            y: t1 * t1 * point1.y + 2 * t * t1 * controlPoint.y + t * t * point2.y
        )
    }
}
