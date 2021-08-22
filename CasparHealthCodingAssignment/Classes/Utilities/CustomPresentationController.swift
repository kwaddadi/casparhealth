//
//  CustomPresentationController.swift
//  test
//
//  Created by Gennady Berezovsky on 20.03.18.
//  Copyright © 2018 Gennady Berezovsky. All rights reserved.
//

import UIKit

class CustomPresentationController: UIPresentationController {
    
    private struct Constants {
        static let kAnimationDuration = 0.3
    }
    
    override init(presentedViewController: UIViewController, presenting: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presenting)
        presentedViewController.modalPresentationStyle = .custom
    }
    
    func animatedViewFor(transitionContext: UIViewControllerContextTransitioning) -> UIView {
        guard let fromViewController = transitionContext.viewController(forKey: .from) else {
            fatalError()
        }
        
        let toView = transitionContext.view(forKey: .to)
        
        let containerView = transitionContext.containerView
        
        let isPresenting = fromViewController == self.presentingViewController
        
        if let toViewUnwrapped = transitionContext.view(forKey: .to) {
            containerView.addSubview(toViewUnwrapped)
        }
        
        if isPresenting {
            guard let toView = toView else {
                fatalError()
            }
            
            toView.alpha = 0
            
            return toView
        } else {
            guard let fromView = transitionContext.view(forKey: .from) else {
                fatalError()
            }
            
            return fromView
        }
    }

}

extension CustomPresentationController: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return Constants.kAnimationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let view = self.animatedViewFor(transitionContext: transitionContext)
        
        guard let fromViewController = transitionContext.viewController(forKey: .from) else {
            fatalError()
        }
        let isPresenting = fromViewController == self.presentingViewController
        self.presentingViewController.beginAppearanceTransition(!isPresenting, animated: true)
        
        UIView.animate(withDuration: Constants.kAnimationDuration, animations: {
            view.alpha = abs(1 - view.alpha)
        }, completion: { (_) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            self.presentingViewController.endAppearanceTransition()
        })
    }

}

extension CustomPresentationController: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
}
