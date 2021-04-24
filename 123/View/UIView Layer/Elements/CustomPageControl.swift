//
//  CustomPageControl.swift
//  123
//
//  Created by Storm67 on 04/04/2021.
//  Copyright © 2021 gdml. All rights reserved.
//

import Foundation
import UIKit

class PageControl: UIControl {
    
    fileprivate var circles = [Circle]()
    fileprivate var image = UIImageView()
    var pages = 0
    var currentPage: Int = 0
    var circle: Circle
    var width = CGFloat(12)
    
    required init(circle: Circle) {
        self.circle = circle
        super.init(frame: .null)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func pagesCounter(offset: CGPoint, width: CGFloat) {
        var lastPage: Int = 0
        if currentPage == 0 {
            image.tintColor = .black
            circles[0].fillColor = .lightGray
        } else { image.tintColor = .lightGray }
        if offset.x == 0 {
            lastPage = currentPage
            currentPage -= 1
        }
        if offset.x == width * 2  {
            lastPage = currentPage
            currentPage += 1
        }
        if currentPage >= 1 {
        circles[currentPage - 1].fillColor = .black
        if lastPage >= 1 {
        circles[lastPage - 1].fillColor = .lightGray
        }
        update()
        }
    }
    
    func update() {
        for i in 0..<circles.count {
            circles[i].setNeedsDisplay()
        }
    }
    
    func addCircle(_ bool: Bool) {
        subviews.forEach { $0.removeFromSuperview() }
        circles = []
        self.image.image = UIImage(systemName: "location.fill")?.withRenderingMode(.alwaysTemplate)
        if !bool {
        self.image.tintColor = UIColor.black
        } else { image.tintColor = .lightGray
        addSubview(self.image)
        let xMargin = CGFloat(pages) * (width / 1.7)
        var x = bounds.minX - xMargin
        image.frame = CGRect(x: x, y: bounds.midY - 1, width: 10, height: 10)
        circles.removeAll()
        x -= width / 2
        for v in 0..<pages - 1 {
        circles.append(Circle(frame: .zero, strokeColor: .clear, fillColor: .lightGray))
        addSubview(circles[v])
        x += width / 2 * 2.5
        circles[v].frame = CGRect(x: Int(x), y: Int(bounds.midY), width: 10, height: 5)
        circles[v].setNeedsDisplay()
        circles[0].fillColor = .black
            }
        }
        print(pages)
    }
}
