//
//  WaterController.swift
//  Physics
//
//  Created by Kiran Kunigiri on 7/18/15.
//  Copyright (c) 2015 Kiran Kunigiri. All rights reserved.
//

import Foundation
import UIKit

protocol RainControllerProtocol {
    func start()
}

class RainController: RainControllerProtocol {
    
    // MARK: - Properties
    
    // MARK: Views
    var view: UIView!
    var toDraw: UIView!
    var mask: UIView!
    var cloudView: UIImageView!
    var frame: CGRect
    private var drops: [UIView] = []
    private var dropColor = UIColor(red:0.56, green:0.76, blue:0.85, alpha:1.0)
    
    // MARK: Drop behaviors
    private var animator: UIDynamicAnimator!
    private var gravityBehavior = UIGravityBehavior()
    private var timer1 = Timer()
    private var timer2 = Timer()
    private var timer3 = Timer()
    private var timer4 = Timer()
    // MARK: State
    
    // MARK: - Methods
    init(view: UIView, frame: CGRect) {
        self.view = view
        self.frame = frame
        animator = UIDynamicAnimator(referenceView: self.view)
        gravityBehavior.gravityDirection.dy = 0.1
        animator.addBehavior(gravityBehavior)
    }
    
    func createBackground() {
    mask = UIView()
    mask.center = view.center
    mask.frame = CGRect(x: 0, y: -100, width: 195, height: 185)
    mask.backgroundColor = .none
    mask.clipsToBounds = true
    view.addSubview(mask)
    toDraw = UIView()
    toDraw.center = view.center
    toDraw.frame = CGRect(x: -30, y: -200, width: 111, height: 460)
    toDraw.backgroundColor = .none
    toDraw.transform = CGAffineTransform(rotationAngle: 19)
    mask.addSubview(toDraw)
    }
    

    /** Starts the rain animation */
    func start() {
        createBackground()
        timer1 = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(spawnFirst), userInfo: nil, repeats: true)
       timer3 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(remove), userInfo: nil, repeats: true)
//        timer4 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(spawnSecond), userInfo: nil, repeats: true)
    }
    
    @objc func randomizer() -> CGFloat {
        CGFloat.random(in: 0.01...0.01)
    }
    
    // MARK: - Helper Methods
    
    private func addGravity(array: [UIView]) {
        for drop in array {
            gravityBehavior.addItem(drop)
        }
    }
    
    @objc private func spawnFirst() {
        //creates array of UIViews (drops)
        var thisArray: [UIView] = []
        let numberOfDrops = Int.random(in: 1...1)
        for _ in 0 ..< numberOfDrops {
            let width = CGFloat(Int.random(in: 1...2))
            let height = CGFloat(Int.random(in: 3...5))
            let newX = CGFloat(Int.random(in: Int(toDraw.bounds.minX)...Int(view.bounds.width / 1.3)))
            let drop = UIImageView(image: UIImage(named: "rain"))
            drop.frame = CGRect(x: newX, y: 0, width: width, height: height)
            drop.backgroundColor = dropColor
            view.insertSubview(drop, at: 5)
            self.drops.append(drop)
            thisArray.append(drop)
        }
        addGravity(array: thisArray)
    }
    
    @objc func remove() {
          for item in 0..<drops.count {
            if drops[item].bounds.origin.y > view.bounds.maxY {
              drops[item].removeFromSuperview()
              gravityBehavior.removeItem(drops[item])
              drops.remove(at: item)
              }
          }
      }
    
    @objc private func spawn() {
        //creates array of UIViews (drops)
        var thisArray: [UIView] = []
        let numberOfDrops = Int.random(in: 2...3)
        let width = CGFloat(Int.random(in: 1...2))
        let height = CGFloat(Int.random(in: 2...4))
        for _ in 0 ..< numberOfDrops {
            let newX = CGFloat(Int.random(in: Int(toDraw.bounds.minX)...Int(view.bounds.width / 1.3)))
            let newY = CGFloat(Int.random(in: (-100)...(-50)))
            let drop = UIImageView(image: UIImage(named: "rain"))
            drop.frame = CGRect(x: newX, y: newY, width: width, height: height)
            drop.backgroundColor = dropColor
            view.insertSubview(drop, at: 5)
            self.drops.append(drop)
            thisArray.append(drop)
        }
        addGravity(array: thisArray)
    }
}

