//
//  PresentationController.swift
//  123
//
//  Created by Storm67 on 11/04/2021.
//  Copyright © 2021 gdml. All rights reserved.
//

import Foundation
import UIKit

class PresentationController: UIPresentationController {
    
    override var shouldPresentInFullscreen: Bool {
        return false
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        let bounds = containerView!.bounds
        let halfHeight = bounds.height / 3
        return CGRect(x: 0,
                      y: halfHeight,
                      width: bounds.width,
                      height: bounds.height)
    }
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        containerView?.addSubview(presentedView!)
    }
    
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
 
}
