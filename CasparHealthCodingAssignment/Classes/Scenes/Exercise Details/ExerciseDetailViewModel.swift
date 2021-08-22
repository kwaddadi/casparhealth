//
//  ExerciseDetailPresentationControl.swift
//  CasparHealth
//
//  Created by Gennady Berezovsky on 07.06.18.
//  Copyright © 2018 GOREHA GmbH. All rights reserved.
//

import UIKit
import TagListView

class ExerciseDetailViewModel: NSObject {
    
    @IBOutlet weak var videoActivityIndicator: UIActivityIndicatorView?
    @IBOutlet weak var videoContainerView: UIView? {
        didSet {
            videoContainerView?.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var screenTitleLabel: UILabel! {
        didSet {
            screenTitleLabel.font = UIFont.roboto()
            screenTitleLabel.text = NSLocalizedString("My Training", comment: "")
        }
    }
    
    @IBOutlet weak var trainingProgressHeaderView: HorizontalEdgeShadowView! {
        didSet {
            trainingProgressHeaderView.shadowEdgesOptions = [.bottom]
        }
    }
    
    @IBOutlet weak var exerciseTitleLabel: UILabel! {
        didSet {
            exerciseTitleLabel.textColor = UIColor.primaryText
        }
    }
    
    @IBOutlet weak var exerciseNumberLabel: UILabel! {
        didSet {
            exerciseNumberLabel.textColor = UIColor.primaryText
        }
    }
    
    @IBOutlet weak var curveView: ExerciseDetailsCurveView!
    
    // MARK: Reps and Sets Count views
    
    @IBOutlet weak var setsCountView: ExerciseSetsRepsCountView!
    @IBOutlet weak var repsCountView: ExerciseSetsRepsCountView!
    
    @IBOutlet weak var setsTitleLabel: UILabel! {
        didSet {
            setsTitleLabel.textColor = UIColor.secondaryText
            setsTitleLabel.text = NSLocalizedString("Sets", comment: "").uppercased()
        }
    }
    @IBOutlet weak var repsTitleLabel: UILabel! {
        didSet {
            repsTitleLabel.textColor = UIColor.secondaryText
            repsTitleLabel.text = NSLocalizedString("Reps", comment: "").uppercased()
        }
    }
    
    // MARK: Equipment Views
    
    @IBOutlet weak var toolsTitleLabel: UILabel! {
        didSet {
            toolsTitleLabel.textColor = UIColor.secondaryText
            toolsTitleLabel.text = NSLocalizedString("ExerciseInfo_ToolsLabel_Title", comment: "Title for an exercise quipment section").uppercased()
        }
    }
    
    @IBOutlet weak var equipmentListView: TagListView! {
        didSet {
            equipmentListView.tagBackgroundColor = .equipmentTagBackground
            equipmentListView.textColor = .equipmentTagText
            equipmentListView.textFont = UIFont.roboto(forTextStyle: .callout)
            equipmentListView.tagLineBreakMode = .byTruncatingTail
        }
    }
    
    // MARK: Separators
    
    @IBOutlet weak var verticalSeparatorView: UIView! {
        didSet {
            verticalSeparatorView.backgroundColor = UIColor.separator
        }
    }
    @IBOutlet weak var horizontalSeparatorView: UIView! {
        didSet {
            horizontalSeparatorView.backgroundColor = UIColor.separator
        }
    }
    
    // MARK: Buttons
    
    @IBOutlet weak var instructionsButton: UIButton! {
        didSet {
            instructionsButton.setTitleColor(UIColor.exerciseInfoButton, for: .normal)
            instructionsButton.titleLabel?.font = UIFont.roboto(weight: .medium)
            instructionsButton.setTitle(NSLocalizedString("ExerciseInfo_InstructionButton_Title", comment: "Instruction button title for the exercise").uppercased(), for: .normal)
        }
    }
    @IBOutlet weak var settingsButton: UIButton! {
        didSet {
            settingsButton.setTitleColor(UIColor.exerciseInfoButton, for: .normal)
            settingsButton.titleLabel?.font = UIFont.roboto(weight: .medium)
            settingsButton.setTitle(NSLocalizedString("Settings", comment: "Instruction button title for the exercise").uppercased(), for: .normal)
        }
    }
    @IBOutlet weak var skipButton: LoadingIndicatorButton! {
        didSet {
            skipButton.style = .replaceTitleLabel
            skipButton.backgroundColor = UIColor.white
            skipButton.setTitleColor(UIColor.exerciseInfoButton, for: .normal)
            skipButton.setTitle(NSLocalizedString("Skip", comment: "").uppercased(), for: .normal)
        }
    }
    
    @IBOutlet weak var startButton: LoadingIndicatorButton! {
        didSet {
            startButton.style = .replaceImageView
            startButton.isEnabled = false
            startButton.backgroundColor = UIColor.exerciseInfoButton
            startButton.setTitleColor(UIColor.white, for: .normal)
            startButton.setTitle(NSLocalizedString("Start", comment: "").uppercased(), for: .normal)
        }
    }
    @IBOutlet weak var watchButton: UIButton! {
        didSet {
            watchButton.isHidden = true
            watchButton.setTitle(NSLocalizedString("ExerciseInfo_WatchButton_Title", comment: "Watch button on an exercise video").uppercased(), for: .normal)
            watchButton.titleLabel?.font = UIFont.roboto(forTextStyle: .subheadline, weight: .semibold)
            watchButton.backgroundColor = UIColor.exerciseInfoButton
        }
    }
    
    // MARK: Bottom views
    
    @IBOutlet weak var therapistAdviceView: ExerciseTherapistAdviceView! {
        didSet {
            therapistAdviceView.alpha = 0
            therapistAdviceView.layer.cornerRadius = 5
            therapistAdviceView.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var bottomButtonsSeparatorView: UIView! {
        didSet {
            bottomButtonsSeparatorView.backgroundColor = UIColor.separator
        }
    }
}
