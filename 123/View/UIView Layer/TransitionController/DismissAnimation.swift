//
//  DismissAnimation.swift
//  123
//
//  Created by Storm67 on 20/04/2021.
//  Copyright © 2021 gdml. All rights reserved.
//

import UIKit

class DismissAnimation: NSObject {
    let duration: TimeInterval = 1

    private func animator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        let from = transitionContext.view(forKey: .from)!
        let initialFrame = transitionContext.initialFrame(for: transitionContext.viewController(forKey: .from)!)

        let animator = UIViewPropertyAnimator(duration: duration, curve: .easeOut) {
            from.frame = initialFrame.offsetBy(dx: 0, dy: initialFrame.height)
        }

        animator.addCompletion { (position) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }

        return animator
    }
}

extension DismissAnimation: UIViewControllerAnimatedTransitioning {
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
