//
//  PresentAnimation.swift
//  123
//
//  Created by Storm67 on 20/04/2021.
//  Copyright © 2021 gdml. All rights reserved.
//

import UIKit

class PresentAnimation: NSObject {
    let duration: TimeInterval = 0.5

    private func animator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        let container = transitionContext.containerView
        let to = transitionContext.view(forKey: .to)!
        container.addSubview(to)
        let finalFrame = transitionContext.finalFrame(for: transitionContext.viewController(forKey: .to)!)
        to.frame = finalFrame.offsetBy(dx: 0, dy: finalFrame.height)
        transitionContext.view(forKey: .from)
        let animator = UIViewPropertyAnimator(duration: duration, curve: .easeOut) {
            to.frame = finalFrame 
        }

        animator.addCompletion { (position) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }

        return animator
    }
}

extension PresentAnimation: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let animator = self.animator(using: transitionContext)
        animator.startAnimation()
    }

    func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        return self.animator(using: transitionContext)
    }
}
