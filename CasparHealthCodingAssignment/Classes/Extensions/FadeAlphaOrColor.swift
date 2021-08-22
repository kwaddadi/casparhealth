//
//  FadeAlphaOrColor.swift
//  CH_PatientApp
//
//  Created by Rui Miguel on 6/2/17.
//  Copyright © 2017 GOREHA GmbH. All rights reserved.
//

import UIKit

extension UIView {
    
    /**
     Animate view's alpha property.
     
     - parameters:
     - to: Destination alpha.
     - duration: Animation duration in seconds.
     - delay: Delay before animation, in seconds.
     - completion: Function to execute when animation completes.
     */
    func fade(to newAlpha: CGFloat, duration: TimeInterval, delay: TimeInterval = 0, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseInOut, animations: { 
            self.alpha = newAlpha
        }, completion: { _ in
            completion?()
        })
    }
    
    func fadeOut(withDuration duration: TimeInterval = 0.25, completion: (() -> Void)? = nil) {
        fade(to: 0, duration: duration, completion: completion)
    }
    
    func fadeOutAndHide(withDuration duration: TimeInterval = 0.25, completion: (() -> Void)? = nil) {
        fadeOut(withDuration: duration) { 
            self.isHidden = true
            completion?()
        }
    }
    
    func fadeIn(withDuration duration: TimeInterval = 0.25, delay: TimeInterval = 0, completion: (() -> Void)? = nil) {
        fade(to: 1, duration: duration, delay: delay, completion: completion)
    }
    
    func fadeOutThenIn(fullDuration: TimeInterval = 0.25, delay: TimeInterval = 0, whileTransparent: @escaping () -> Void, completion: (() -> Void)? = nil) {
        let halfDuration = fullDuration/2
        fadeOut(withDuration : halfDuration) { [weak self] in
            // Only execute code if self exists
            guard self != nil else { return }
            whileTransparent()
            // Fade back in
            self?.fadeIn(withDuration : halfDuration, completion: completion)
        }
    }
    
    func animateBgColor(to newColor: UIColor,
                        duration: TimeInterval = 0.25,
                        delay: TimeInterval = 0,
                        options: UIView.AnimationOptions = [.curveEaseInOut, .beginFromCurrentState],
                        completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration, delay: delay, options: options, animations: {
            self.backgroundColor = newColor
        }, completion: { (_) in
            completion?()
        })
    }
}
