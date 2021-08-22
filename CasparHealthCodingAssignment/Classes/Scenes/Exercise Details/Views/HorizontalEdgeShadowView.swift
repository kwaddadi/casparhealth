//
//  HorizontalEdgeShadowView.swift
//  CasparHealth
//
//  Created by Gennadii Berezovskii on 28.06.18.
//  Copyright © 2018 GOREHA GmbH. All rights reserved.
//

import UIKit

struct ShadowEdges: OptionSet {
    let rawValue: Int
    
    static let top = ShadowEdges(rawValue: 1 << 0)
    static let bottom = ShadowEdges(rawValue: 1 << 1)
}

class HorizontalEdgeShadowView: UIView {
    
    var shadowEdgesOptions: ShadowEdges = [] {
        didSet {
            setNeedsLayout()
        }
    }
    
    private struct Constants {
        static let shadowHeight: CGFloat = 5.0
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initializeSubviews()
    }
    
    func initializeSubviews() {
        self.layer.shadowRadius = Constants.shadowHeight
        self.layer.shadowColor = UIColor.shadow.cgColor
        self.layer.shadowOpacity = 0.5
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let yOrigin = shadowEdgesOptions.contains(.top) ? 0 : self.bounds.maxY
        let height = shadowEdgesOptions.contains([.top, .bottom]) ? self.bounds.height + Constants.shadowHeight * 2 : Constants.shadowHeight
        
        let shadowRect = CGRect(x: 0, y: yOrigin, width: self.bounds.width, height: height)
        self.layer.shadowPath = CGPath(rect: shadowRect, transform: nil)
    }
    
}
