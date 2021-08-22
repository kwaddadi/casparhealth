//
//  ExerciseSetsRepsCountView.swift
//  CasparHealth
//
//  Created by Gennady Berezovsky on 07.06.18.
//  Copyright © 2018 GOREHA GmbH. All rights reserved.
//

import UIKit

class ExerciseSetsRepsCountView: CircleView {
    
    @IBOutlet weak var textLabel: UILabel!
    
    var setsRepsCount: Int = 0 {
        didSet {
            textLabel.text = String(setsRepsCount)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        textLabel.textColor = UIColor.primaryText
    }
    
}
