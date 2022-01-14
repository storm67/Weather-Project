//
//  Charts.swift
//  123
//
//  Created by Storm67 on 22/03/2021.
//  Copyright © 2021 gdml. All rights reserved.
//

import Foundation
import UIKit

class Charts: UIView {
    
    var labelTemp = [UILabel]()
    var labelHour = [UILabel]()
    
    var data: [Int] = [] {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var labels: [String] = ["13°","15°","14°","11°","12°"]
    var hourLabels: [String] = ["Сейчас","10:00","15:00","20:00","24:00"]
    var count = 0
    
    override func draw(_ rect: CGRect) {
        drawer()
        setNeedsDisplay()
    }
    
    func score() -> [Int] {
        var empty = Array(repeating: 0, count: data.count)
        let array = data.sorted()
        for value in array {
            let num = array.firstIndex(of: value)! + 1
            empty[data.firstIndex(of: value)!] = num
        }
        return empty
    }
    
    private func drawCurvedChart() {
        if let path = CurveAlgorithm.shared.createCurvedPath(new()) {
            let lineLayer = CAShapeLayer()
            lineLayer.path = path.cgPath
            lineLayer.strokeColor = UIColor.red.cgColor
            lineLayer.fillColor = UIColor.red.cgColor
            layer.addSublayer(lineLayer)
        }
    }
    
    func YPoint(_ array: [Int], _ iterrator: Int) -> CGFloat {
        if let max = array.max(), let min = array.min() {
        if array[iterrator] == max {
            return bounds.minY
        } else if array[iterrator] == min {
            return bounds.maxY
        } else { return bounds.height * (1 - (CGFloat(data[iterrator]) / CGFloat(max))) }
        }
        return 0
    }
    
    func new() -> [CGPoint] {
        var array = [CGPoint]()
        guard !data.isEmpty else { return [] }
            for i in 0..<data.count {
                let x = CGFloat(Int(bounds.width) / data.count * (i + 1))
                let y = YPoint(data, i)
                let point = CGPoint(x: x, y: y)
                array.append(point)
            }
            return array
    }
    
    func drawer() {
        drawCurvedChart()
    }
    
    func subtraction(height: Int) -> [Int] {
        guard let max = data.max() else { return [] }
        var array = Array(repeating: 0, count: data.count)
        let num = (height - 60) / max
        for (key,item) in data.enumerated() {
            array[key] = (item * num)
        }
        return array
    }
    
    func addCircle(x: CGFloat, y: CGFloat) {
        let circle = CircleCharts(frame: CGRect(x: x - 7, y: y - 6, width: 7, height: 7), strokeColor: .gray, fillColor: .white)
        circle.backgroundColor = .clear
        addSubview(circle)
    }
    
    func addCircle(x: CGFloat, y: CGFloat, color: UIColor) {
        let circle = CircleCharts(frame: CGRect(x: x - 7, y: y - 6, width: 7, height: 7), strokeColor: color, fillColor: .white)
        circle.fillLayer.shadowColor = UIColor.systemBlue.cgColor
        circle.fillLayer.shadowRadius = 4.0
        circle.fillLayer.shadowOpacity = 0.6
        circle.fillLayer.shadowOffset = CGSize(width: 0, height: 0)
        circle.backgroundColor = .clear
        addSubview(circle)
    }
    
    func yAxis(x: CGFloat) {
        let yAxis = UIView()
        yAxis.backgroundColor = .lightGray
        yAxis.layer.opacity = 0.1
        yAxis.frame = CGRect(x: x, y: 0, width: 1, height: bounds.height - 60)
        addSubview(yAxis)
    }
    
    func addTempLabels(x: CGFloat, key: Int) {
        labelTemp[key].text = labels[key]
        labelTemp[key].textColor = .black
        addSubview(labelTemp[key])
        labelTemp[key].frame = CGRect(x: x - 7.5, y: bounds.height - 45, width: 30, height: 15)
    }
    
    func addHourLabels(x: CGFloat, key: Int) {
        labelHour[key].text = hourLabels[key]
        labelHour[key].textColor = #colorLiteral(red: 0.7502692342, green: 0.7503965497, blue: 0.7502524853, alpha: 1)
        labelHour[key].font = UIFont(name: "ArialMT", size: 10)
        addSubview(labelHour[key])
        labelHour[key].frame = CGRect(x: x - 10.5, y: bounds.height - 25, width: 50, height: 15)
        
    }
    
    func addLabels(x: CGFloat, color: UIColor, key: Int) {
        labelTemp[key].text = labels[key]
        labelTemp[key].textColor = color
        addSubview(labelTemp[key])
        labelTemp[key].frame = CGRect(x: x - 5.5, y: bounds.height - 45, width: 30, height: 15)
    }
    
    func removeAll() {
        for views in subviews {
            views.isHidden = true
        }
    }
    
}

class CircleCharts: UIView {
    let fillLayer = CAShapeLayer()
    var strokeColor: UIColor = .blue
    var fillColor: UIColor = #colorLiteral(red: 0.6117964387, green: 0.7582360506, blue: 1, alpha: 1)
    lazy var float: CGFloat = frame.height / 2
    lazy var circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.width, y: frame.height), radius: float, startAngle: CGFloat(0), endAngle: CGFloat.pi * 2, clockwise: true)
    
    
    init(frame: CGRect, strokeColor: UIColor, fillColor: UIColor = #colorLiteral(red: 0.6117964387, green: 0.7582360506, blue: 1, alpha: 1)) {
        self.strokeColor = strokeColor
        self.fillColor = fillColor
        super.init(frame: frame)
        backgroundColor = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        strokeColor.setStroke()
        fillColor.setFill()
        circlePath.stroke()
        fillLayer.path = circlePath.cgPath
        fillLayer.fillColor = fillColor.cgColor
        fillLayer.strokeColor = strokeColor.cgColor
        fillLayer.lineWidth = 2
        circlePath.lineWidth = 1
        layer.addSublayer(fillLayer)
    }
    
}
