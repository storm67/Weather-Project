//
//  BackgroundTransitionController.swift
//  123
//
//  Created by Storm67 on 20/04/2021.
//  Copyright © 2021 gdml. All rights reserved.
//

import UIKit

class BackgroundTransitionController: PresentationController {
    
   override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        
        containerView?.insertSubview(transparencyView, at: 0)
        
        
        performAlongsideTransitionIfPossible { [unowned self] in
            self.transparencyView.alpha = 1
        }
    }
    
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        transparencyView.frame = containerView!.frame
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        super.presentationTransitionDidEnd(completed)
        
        if !completed {
            self.transparencyView.removeFromSuperview()
        }
    }
    
    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        
        performAlongsideTransitionIfPossible { [unowned self] in
            self.transparencyView.alpha = 0
        }
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        super.dismissalTransitionDidEnd(completed)
        
        if completed {
            self.transparencyView.removeFromSuperview()
        }
    }
    
    private func performAlongsideTransitionIfPossible(_ block: @escaping () -> Void) {
        guard let coordinator = self.presentedViewController.transitionCoordinator else {
            block()
            return
        }
            
        coordinator.animate(alongsideTransition: { (_) in
            block()
        }, completion: nil)
    }
    
    private lazy var transparencyView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.3)
        view.alpha = 0
        return view
    }()
    
}
