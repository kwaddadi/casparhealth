//
//  ExerciseTherapistAdviceView.swift
//  CasparHealth
//
//  Created by Gennady Berezovsky on 07.06.18.
//  Copyright © 2018 GOREHA GmbH. All rights reserved.
//

import UIKit

class ExerciseTherapistAdviceView: UIView {
    
    @IBOutlet weak var leftBorderView: UIView? {
        didSet {
            leftBorderView?.backgroundColor = UIColor.accent
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel? {
        didSet {
            titleLabel?.textColor = UIColor.primaryText
            titleLabel?.font =  UIFont.roboto(forTextStyle: .subheadline, weight: .semibold)
            titleLabel?.text = NSLocalizedString("ExerciseInfo_TherapistAdvice_Title", comment: "Therapist advice view title for the exercise")
            titleLabel?.alpha = 0.8
        }
    }
    
    @IBOutlet weak var subtitleLabel: UILabel? {
        didSet {
            subtitleLabel?.textColor = UIColor.primaryText
            subtitleLabel?.font = UIFont.roboto(forTextStyle: .subheadline).italic
            subtitleLabel?.alpha = 0.8
        }
    }
 
    override func awakeFromNib() {
        super.awakeFromNib()

        self.backgroundColor = UIColor.lightAccent
    }
    
}
