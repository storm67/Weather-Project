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
    
    var touchModule: TransitionTouchModule!
    
    override var shouldPresentInFullscreen: Bool {
        return false
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        let bounds = containerView!.bounds
        return CGRect(x: 0,
                      y: bounds.height / 2.4,
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
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        super.presentationTransitionDidEnd(completed)
        
        if completed {
            touchModule.direction = .dismiss
        }
    }
}
