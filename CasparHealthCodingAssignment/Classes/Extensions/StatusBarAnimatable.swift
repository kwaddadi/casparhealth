//
//  StatusBarAnimatable.swift
//  CasparHealth
//
//  Created by Gennadii Berezovskii on 28.06.18.
//  Copyright © 2018 GOREHA GmbH. All rights reserved.
//

import UIKit

protocol StatusBarAnimatable: class {
    var shouldHideStatusBar: Bool { get set }
    
    func updateStatusBarStateTo(hidden: Bool)
}

extension StatusBarAnimatable where Self: UIViewController {
    
    func updateStatusBarStateTo(hidden: Bool) {
        self.shouldHideStatusBar = hidden
        UIView.animate(withDuration: 0.25) {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
}
