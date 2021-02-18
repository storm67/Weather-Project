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
    
    fileprivate let graph = UIView(frame: CGRect(x: 15, y: 125, width: 360, height: 1))
    override init(frame: CGRect) {
        super.init(frame: frame)
        graph.backgroundColor = .white
        addSubview(graph)
    }
    
     required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
       }
    
    override func draw(_ rect: CGRect) {
         let centre = CGPoint(x: bounds.size.width/2, y: 125)
         let path = UIBezierPath(arcCenter: centre, radius: 100.0, startAngle: .pi, endAngle: 2.0 * .pi, clockwise: true)
         let dashes: [ CGFloat ] = [ 16.0, 14.0 ]
         path.setLineDash(dashes, count: dashes.count, phase: 0.0)
         UIColor.white.setStroke()
         path.lineWidth = 2
         path.stroke()
       }
}
