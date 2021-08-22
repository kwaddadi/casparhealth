//
//  CircularButton.swift
//  CH_PatientApp
//
//  Created by Rui Miguel on 27/2/17.
//  Copyright © 2017 GOREHA GmbH. All rights reserved.
//

import UIKit

class CircularButton: LoadingIndicatorButton {
    
    private struct Constants {
        static let defaultButtonHeight: CGFloat = 42.0
    }
    
    override func initialize() {
        super.initialize()
        makeCircle()
        
        let imageViewBounds = imageView?.bounds ?? .zero
        let titleLabelBounds = titleLabel?.bounds ?? .zero
        
        let verticalInset: CGFloat = (Constants.defaultButtonHeight - max(imageViewBounds.height, titleLabelBounds.height)) / 2.0
        
        contentEdgeInsets = UIEdgeInsets(top: verticalInset, left: 20, bottom: verticalInset, right: 20)
        if !imageViewBounds.isEmpty {
            titleEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 8)
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        makeCircle()
    }
    
    func makeCircle() {
        layer.cornerRadius = min(bounds.width, bounds.height) / 2
    }

}
