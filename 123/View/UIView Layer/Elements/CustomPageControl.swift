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
    
    var pages = 0
    var currentPage: Int = 0
    fileprivate var circle = [Circle]() 
    fileprivate var image = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func pagesCounter(offset: CGPoint, width: CGFloat) {
        var lastPage: Int = 0
        if currentPage == 0 {
            image.tintColor = .black
            circle[0].fillColor = .lightGray
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
        circle[currentPage - 1].fillColor = .black
        if lastPage >= 1 {
        circle[lastPage - 1].fillColor = .lightGray
        }
        update()
        }
    }
    
    func update() {
        for i in 0..<circle.count {
            circle[i].setNeedsDisplay()
            layoutIfNeeded()
        }
//        let bool = circle.count == pages ? true : false
//        if !bool {
//        for i in circle.count..<pages {
//        circle[i - 1].removeFromSuperview()
//        circle[i - 1].setNeedsDisplay()
//        }
//        }
    }

    func delete(_ diff: Int) {
        
    }
    
    func addCircle() {
        subviews.forEach { $0.removeFromSuperview() }
        self.image.image = UIImage(systemName: "location.fill")?.withRenderingMode(.alwaysTemplate)
        self.image.tintColor = UIColor.black
        addSubview(self.image)
        var x = bounds.minX
        image.frame = CGRect(x: x + 5, y: bounds.midY - 1, width: 10, height: 10)
        circle.removeAll()
        for v in 0..<pages - 1 {
        circle.append(Circle(frame: .zero, strokeColor: .clear, fillColor: .lightGray))
        addSubview(circle[v])
        x += 5 * 2.5
        circle[v].frame = CGRect(x: Int(x), y: Int(bounds.midY), width: 10, height: 5)
        circle[v].setNeedsDisplay()
        layoutIfNeeded()
        }
    }
}
