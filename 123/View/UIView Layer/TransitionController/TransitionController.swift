//
//  TransitionController.swift
//  123
//
//  Created by Storm67 on 11/04/2021.
//  Copyright © 2021 gdml. All rights reserved.
//

import UIKit

class TransitionController: NSObject, UIViewControllerTransitioningDelegate {

// MARK: - Presentation controller
private let driver = TransitionTouchModule()

func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
    driver.link(to: presented)
    
    let presentationController = BackgroundTransitionController(presentedViewController: presented,
                                                            presenting: presenting ?? source)
    presentationController.touchModule = driver

    return presentationController
}

// MARK: - Animation
func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return PresentAnimation()
}

func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return DismissAnimation()
}

// MARK: - Interaction
func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
    return driver
}

func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
    return driver
    }
}
