//
//  BackgroundTransitionController.swift
//  123
//
//  Created by Storm67 on 20/04/2021.
//  Copyright © 2021 gdml. All rights reserved.
//

import UIKit

class BackgroundTransitionController: PresentationController {
    
    var transparencyView: UIView = {
        let uiview = UIView()
        uiview.alpha = 0
        return uiview
    }()
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        transitionAnimator {
            self.transparencyView.alpha = 1
        }
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        super.presentationTransitionWillBegin()
        if completed {
            transparencyView.removeFromSuperview()
        }
    }
    
    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
    }
    
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        containerView?.addSubview(transparencyView)
    }
    
    private func transitionAnimator(_ block: @escaping () -> Void) {
        guard let coordinator = self.presentedViewController.transitionCoordinator else {
            block()
            return
        }
            
        coordinator.animate(alongsideTransition: { (_) in
            block()
        }, completion: nil)
    }
    
}
