//
//  LineChart.swift
//  LineChart
//
//  Created by Nguyen Vu Nhat Minh on 25/8/17.
//  Copyright © 2017 Nguyen Vu Nhat Minh. All rights reserved.
//

import UIKit
struct CurvedSegment {
    var controlPoint1: CGPoint
    var controlPoint2: CGPoint
}

class CurveAlgorithm {
    static let shared = CurveAlgorithm()
    
    func controlPointsFrom(points: [CGPoint]) -> [CurvedSegment] {
        var result: [CurvedSegment] = []
        
        let delta: CGFloat = 0.3 // The value that help to choose temporary control points.
        
        // Calculate temporary control points, these control points make Bezier segments look straight and not curving at all
        for i in 1..<points.count {
            let A = points[i-1]
            let B = points[i]
            let controlPoint1 = CGPoint(x: A.x + delta*(B.x-A.x), y: A.y + delta*(B.y - A.y))
            let controlPoint2 = CGPoint(x: B.x - delta*(B.x-A.x), y: B.y - delta*(B.y - A.y))
            let curvedSegment = CurvedSegment(controlPoint1: controlPoint1, controlPoint2: controlPoint2)
            result.append(curvedSegment)
        }
        
        // Calculate good control points
        for i in 1..<points.count-1 {
            /// A temporary control point
            let M = result[i-1].controlPoint2
            
            /// A temporary control point
            let N = result[i].controlPoint1
            
            /// central point
            let A = points[i]
            
            /// Reflection of M over the point A
            let MM = CGPoint(x: 2 * A.x - M.x, y: 2 * A.y - M.y)
            
            /// Reflection of N over the point A
            let NN = CGPoint(x: 2 * A.x - N.x, y: 2 * A.y - N.y)
            
            result[i].controlPoint1 = CGPoint(x: (MM.x + N.x)/2, y: (MM.y + N.y)/2)
            result[i-1].controlPoint2 = CGPoint(x: (NN.x + M.x)/2, y: (NN.y + M.y)/2)
        }
        
        return result
    }
    
    func point(_ point1: CGPoint,_ controlPoint1: CGPoint, _ controlPoint2: CGPoint, _ point2: CGPoint, at t: CGFloat = 0.1) -> CGPoint {
        let t1: CGFloat = 1 - t
        return CGPoint(
            x: pow(t1, 3) * point1.x + 3 * t * pow(t1, 2) * controlPoint1.x + 3 * pow(t, 2) * t1 * controlPoint2.x + pow(t,3) * point2.x,
            y: pow(t1, 3) * point1.y + 3 * t * pow(t1, 2) * controlPoint1.y + 3 * pow(t, 2) * t1 * controlPoint2.y + pow(t,3) * point2.y
        )
    }
    
    func createPointsForDots(points: [CGPoint]) -> [CGPoint] {
        let controlPoints = CurveAlgorithm.shared.controlPointsFrom(points: points)
        var pointArray = [CGPoint]()
        for i in 1..<controlPoints.count {
        let firstP = controlPoints[i].controlPoint1
        let secondP = controlPoints[i].controlPoint2
        let point = point(points[i - 1], firstP, secondP, points[i])
        pointArray.append(point)
        }
        return pointArray
    }
    
    /**
     Create a curved bezier path that connects all points in the dataset
     */
    func createCurvedPath(_ dataPoints: [CGPoint]) -> UIBezierPath? {
        let path = UIBezierPath()
        path.move(to: dataPoints[0])
        
        var curveSegments: [CurvedSegment] = []
        curveSegments = CurveAlgorithm.shared.controlPointsFrom(points: dataPoints)
        
        for i in 1..<dataPoints.count {
            path.addCurve(to: dataPoints[i], controlPoint1: curveSegments[i-1].controlPoint1, controlPoint2: curveSegments[i-1].controlPoint2)
        }
        return path
    }
    
}

class DotCALayer: CALayer {

    var innerRadius: CGFloat = 8
    var dotInnerColor = UIColor.black

    override init() {
        super.init()
    }

    override init(layer: Any) {
        super.init(layer: layer)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSublayers() {
        super.layoutSublayers()
        let inset = self.bounds.size.width - innerRadius
        let innerDotLayer = CALayer()
        innerDotLayer.frame = self.bounds.insetBy(dx: inset/2, dy: inset/2)
        innerDotLayer.backgroundColor = dotInnerColor.cgColor
        innerDotLayer.cornerRadius = innerRadius / 2
        self.addSublayer(innerDotLayer)
    }

}



struct PointEntry {
    let value: Int
    let label: String
}

extension PointEntry: Comparable {
    static func <(lhs: PointEntry, rhs: PointEntry) -> Bool {
        return lhs.value < rhs.value
    }
    static func ==(lhs: PointEntry, rhs: PointEntry) -> Bool {
        return lhs.value == rhs.value
    }
}

class LineChart: UIView {
    
    /// gap between each point
    let lineGap: CGFloat = 60.0
    
    /// preseved space at top of the chart
    let topSpace: CGFloat = 40.0
    
    /// preserved space at bottom of the chart to show labels along the Y axis
    let bottomSpace: CGFloat = 40.0
    
    /// The top most horizontal line in the chart will be 10% higher than the highest value in the chart
    let topHorizontalLine: CGFloat = 110.0 / 100.0
    
    var isCurved: Bool = false

    /// Active or desactive animation on dots
    var animateDots: Bool = false

    /// Active or desactive dots
    var showDots: Bool = false

    /// Dot inner Radius
    var innerRadius: CGFloat = 8

    /// Dot outer Radius
    var outerRadius: CGFloat = 12
    
    var dataEntries: [PointEntry]? {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    /// Contains the main line which represents the data
    private let dataLayer: CALayer = CALayer()
    
    /// To show the gradient below the main line
    private let gradientLayer: CAGradientLayer = CAGradientLayer()
    
    /// Contains dataLayer and gradientLayer
    private let mainLayer: CALayer = CALayer()
    
    /// Contains mainLayer and label for each data entry
    private let scrollView: UIScrollView = UIScrollView()
    
    /// Contains horizontal lines
    private let gridLayer: CALayer = CALayer()
    
    /// An array of CGPoint on dataLayer coordinate system that the main line will go through. These points will be calculated from dataEntries array
    private var dataPoints: [CGPoint]?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        mainLayer.addSublayer(dataLayer)
        scrollView.layer.addSublayer(mainLayer)
        gradientLayer.colors = [#colorLiteral(red: 0.5836217999, green: 0.7063483, blue: 1, alpha: 1).cgColor, #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor]
        gradientLayer.opacity = 0.4
        scrollView.layer.addSublayer(gradientLayer)
        self.layer.addSublayer(gridLayer)
        self.addSubview(scrollView)
    }
    
    override func layoutSubviews() {
        scrollView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        if let dataEntries = dataEntries {
            scrollView.contentSize = CGSize(width: frame.width, height: self.frame.size.height)
            mainLayer.frame = CGRect(x: 0, y: 0, width: scrollView.frame.width, height: self.frame.size.height)
            dataLayer.frame = CGRect(x: 0, y: mainLayer.frame.height/3, width: mainLayer.frame.width, height: mainLayer.frame.height)
            gradientLayer.frame = dataLayer.frame
            dataPoints = convertDataEntriesToPoints(entries: dataEntries)
            gridLayer.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: mainLayer.frame.height - topSpace - bottomSpace)
            if showDots { drawDots() }
            clean()
            drawHorizontalLines()
            drawCurvedChart()
            maskGradientLayer()
            drawCircle()
        }
    }
    
    /**
     Convert an array of PointEntry to an array of CGPoint on dataLayer coordinate system
     */
    private func convertDataEntriesToPoints(entries: [PointEntry]) -> [CGPoint] {
        if let max = entries.max()?.value,
            let min = entries.min()?.value {
            
            var result: [CGPoint] = []
            let minMaxRange: CGFloat = CGFloat(max - min) * topHorizontalLine
            let height = mainLayer.frame.height / 2 - mainLayer.frame.height/2.5
            let point = CGPoint(x: 0, y: height)
            result.append(point)
            for i in 0..<entries.count {
                let height = dataLayer.frame.height / 5 * (1 - (CGFloat(entries[i].value - min) / minMaxRange))
                var width = CGFloat(i) * dataLayer.frame.width / CGFloat(entries.count - 1)
                if i == entries.startIndex {
                width = width + (dataLayer.frame.width / 6) / 2
                } else if i == entries.endIndex - 1 {
                width = width - (dataLayer.frame.width / 6) / 2
                }
                let point = CGPoint(x: width, y: height)
                result.append(point)
            }
            let lastPoint = CGPoint(x: mainLayer.frame.width, y: dataLayer.frame.height * 0.2)
            result.append(lastPoint)
            return result
        }
        return []
    }
    
    /**
     Draw a zigzag line connecting all points in dataPoints
     */
    private func drawChart() {
        if let dataPoints = dataPoints,
            dataPoints.count > 0,
            let path = createPath() {
            
            let lineLayer = CAShapeLayer()
            lineLayer.path = path.cgPath
            lineLayer.strokeColor = UIColor.black.cgColor
            lineLayer.fillColor = UIColor.clear.cgColor
            dataLayer.addSublayer(lineLayer)
        }
    }

    /**
     Create a zigzag bezier path that connects all points in dataPoints
     */
    private func createPath() -> UIBezierPath? {
        guard let dataPoints = dataPoints, dataPoints.count > 0 else {
            return nil
        }
        let path = UIBezierPath()
        path.move(to: dataPoints[0])
        
        for i in 1..<dataPoints.count {
            path.addLine(to: dataPoints[i])
        }
        return path
    }
    
    /**
     Draw a curved line connecting all points in dataPoints
     */
    private func drawCurvedChart() {
        guard let dataPoints = dataPoints, dataPoints.count > 0 else {
            return
        }
        if let path = CurveAlgorithm.shared.createCurvedPath(dataPoints) {
            let lineLayer = CAShapeLayer()
            lineLayer.path = path.cgPath
            lineLayer.strokeColor = #colorLiteral(red: 0.3647358716, green: 0.4941756725, blue: 1, alpha: 1).cgColor
            lineLayer.lineWidth = 1.5
            lineLayer.fillColor = UIColor.clear.cgColor
            dataLayer.addSublayer(lineLayer)
        }
    }
    
    
    /**
     Create a gradient layer below the line that connecting all dataPoints
     */
    private func maskGradientLayer() {
        if let dataPoints = dataPoints,
            dataPoints.count > 0 {
            
            let path = UIBezierPath()
            path.move(to: CGPoint(x: dataPoints[0].x, y: dataLayer.frame.height))
            path.addLine(to: dataPoints[0])
            if isCurved,
                let curvedPath = CurveAlgorithm.shared.createCurvedPath(dataPoints) {
                path.append(curvedPath)
            } else if let straightPath = createPath() {
                path.append(straightPath)
            }
            path.addLine(to: CGPoint(x: dataPoints[dataPoints.count-1].x, y: dataLayer.frame.height))
            path.addLine(to: CGPoint(x: dataPoints[0].x, y: dataLayer.frame.height))
            
            let maskLayer = CAShapeLayer()
            maskLayer.path = path.cgPath
            maskLayer.fillColor = UIColor.white.cgColor
            maskLayer.strokeColor = UIColor.clear.cgColor
            maskLayer.lineWidth = 0.0
            
            gradientLayer.mask = maskLayer
        }
    }
    
    /**
     Create titles at the bottom for all entries showed in the chart
     */
    private func drawLables() {
        if let dataEntries = dataEntries,
            dataEntries.count > 0 {
            for i in 0..<dataEntries.count {
                let textLayer = CATextLayer()
                textLayer.frame = CGRect(x: lineGap*CGFloat(i) - lineGap/2 + 40, y: mainLayer.frame.size.height, width: lineGap, height: 16)
                textLayer.foregroundColor = #colorLiteral(red: 0.5019607843, green: 0.6784313725, blue: 0.8078431373, alpha: 1).cgColor
                textLayer.backgroundColor = UIColor.clear.cgColor
                textLayer.alignmentMode = CATextLayerAlignmentMode.center
                textLayer.contentsScale = UIScreen.main.scale
                textLayer.font = CTFontCreateWithName(UIFont.systemFont(ofSize: 0).fontName as CFString, 0, nil)
                textLayer.fontSize = 11
                textLayer.string = dataEntries[i].label
                mainLayer.addSublayer(textLayer)
            }
        }
    }
    
    func drawCircle() {
        if let dataEntries = dataEntries {
            let points = convertDataEntriesToPoints(entries: dataEntries)
            let absoluteCurvedPoints = CurveAlgorithm.shared.controlPointsFrom(points: points)
            for i in 1..<points.count {
                let point = CurveAlgorithm.shared.point(points[i],
                                                    absoluteCurvedPoints[i - 1].controlPoint1,
                                                    absoluteCurvedPoints[i - 1].controlPoint2,
                                                    points[i],
                                                    at: 0)
                let rect = CGRect(x: point.x, y: point.y + mainLayer.frame.height/3 - 6, width: 6, height: 6)
                let textLayer = CATextLayer()
                textLayer.frame = CGRect(x: point.x - 2, y: point.y + mainLayer.frame.height/3 - 24, width: 17, height: 16)
                textLayer.foregroundColor = #colorLiteral(red: 0.346722424, green: 0.4321926832, blue: 0.8210842013, alpha: 1).cgColor
                textLayer.backgroundColor = UIColor.clear.cgColor
                textLayer.contentsScale = UIScreen.main.scale
                textLayer.font = CTFontCreateWithName(UIFont.boldSystemFont(ofSize: 0).fontName as CFString, 0, nil)
                textLayer.alignmentMode = .center
                textLayer.fontSize = 16
                if 1...4 ~= i {
                textLayer.string = "\(dataEntries[i - 1].value)°"
                }
                gridLayer.addSublayer(textLayer)
                let view = CircleCharts(frame: rect, strokeColor: #colorLiteral(red: 0.6117964387, green: 0.7582360506, blue: 1, alpha: 1))
                view.backgroundColor = .clear
                addSubview(view)
            }
        }
    }
    
    /**
     Create horizontal lines (grid lines) and show the value of each line
     */
    private func drawHorizontalLines() {
        guard let dataEntries = dataEntries else { return }
        var added = false
            for value in 0...1 {
                let value = CGFloat(value)
                let height = value * gridLayer.frame.size.height
                let width = dataLayer.frame.width / 4
                let path = UIBezierPath()
                if !added {
                path.move(to: CGPoint(x: value * width + 1, y: 0))
                path.addLine(to: CGPoint(x: value * width + 1, y: dataLayer.frame.size.height - 1))
                path.addLine(to: CGPoint(x: dataLayer.frame.size.width, y: dataLayer.frame.size.height - 1))
                added.toggle()
                }
                let lineLayer = CAShapeLayer()
                lineLayer.path = path.cgPath
                lineLayer.fillColor = UIColor.clear.cgColor
                lineLayer.strokeColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1).cgColor
                lineLayer.lineWidth = 2
                if (value > 0.0 && value < 1.0) {
                    lineLayer.lineDashPattern = [4, 4]
                }
                
                gridLayer.addSublayer(lineLayer)
                
                var minMaxGap:CGFloat = 0
                var lineValue:Int = 0
                if let max = dataEntries.max()?.value,
                    let min = dataEntries.min()?.value {
                    minMaxGap = CGFloat(max - min) * topHorizontalLine
                    lineValue = Int((1-value) * minMaxGap) + Int(min)
                }
                
        }
    }
    
    private func clean() {
        mainLayer.sublayers?.forEach({
            if $0 is CATextLayer {
                $0.removeFromSuperlayer()
            }
        })
        dataLayer.sublayers?.forEach({$0.removeFromSuperlayer()})
        gridLayer.sublayers?.forEach({$0.removeFromSuperlayer()})
    }
    /**
     Create Dots on line points
     */
    private func drawDots() {
        var dotLayers: [DotCALayer] = []
        if let dataPoints = dataPoints {
            for dataPoint in dataPoints {
                let xValue = dataPoint.x - outerRadius/2
                let yValue = (dataPoint.y + lineGap) - (outerRadius * 2)
                let dotLayer = DotCALayer()
                dotLayer.dotInnerColor = UIColor.white
                dotLayer.innerRadius = innerRadius
                dotLayer.backgroundColor = UIColor.white.cgColor
                dotLayer.cornerRadius = outerRadius / 2
                dotLayer.frame = CGRect(x: xValue, y: yValue, width: outerRadius, height: outerRadius)
                dotLayers.append(dotLayer)

                mainLayer.addSublayer(dotLayer)

                if animateDots {
                    let anim = CABasicAnimation(keyPath: "opacity")
                    anim.duration = 1.0
                    anim.fromValue = 0
                    anim.toValue = 1
                    dotLayer.add(anim, forKey: "opacity")
                }
            }
        }
    }
}
