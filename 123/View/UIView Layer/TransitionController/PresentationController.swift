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
        guard let containerView = containerView else { return CGRect() }
        return CGRect(x: 0,
                      y: containerView.bounds.height / 2.4,
                      width: containerView.bounds.width,
                      height: containerView.bounds.height)
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
