//
//  CircleView.swift
//  CH_PatientApp
//
//  Created by Rui Miguel on 14/03/2017.
//  Copyright © 2017 GOREHA GmbH. All rights reserved.
//

import UIKit

class CircleView: UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = min(bounds.width, bounds.height)/2
        layer.masksToBounds = true
    }

}
