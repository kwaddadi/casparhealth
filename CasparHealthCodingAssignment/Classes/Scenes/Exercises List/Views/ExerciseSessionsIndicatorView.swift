//
//  ExerciseSessionsIndicatorView.swift
//  CH_PatientApp
//
//  Created by Gennadii Berezovskii on 25.09.18.
//  Copyright © 2018 GOREHA GmbH. All rights reserved.
//

import UIKit

class ExerciseSessionsIndicatorView: UIView {
    
    private struct Constants {
        static let indicatorWidth: CGFloat = 7.0
        static let spacing: CGFloat = 10.0
    }

    var totalCount = 0 {
        didSet {
            resetIndicators()
        }
    }
    var completedCount = 0 {
        didSet {
            resetIndicators()
        }
    }
    
    var containerView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = Constants.spacing
        return stackView
    }()
    var containerViewWidthConstraint: NSLayoutConstraint?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initialize()
    }
    
    func initialize() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(containerView)
        containerView.frame = bounds
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: Constants.indicatorWidth).isActive = true
    }
    
    func resetIndicators() {
        containerView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for index in 0...totalCount - 1 {
            let indicatorView = CircleView(frame: CGRect(x: 0, y: 0, width: Constants.indicatorWidth, height: Constants.indicatorWidth))
            indicatorView.backgroundColor = index < completedCount ? UIColor.exersiceListCompleted : UIColor.accent
            
            containerView.addArrangedSubview(indicatorView)
        }
        
        let constraintValue = CGFloat(totalCount) * Constants.indicatorWidth + CGFloat(totalCount - 1) * Constants.spacing
        if containerViewWidthConstraint == nil {
            containerViewWidthConstraint = containerView.widthAnchor.constraint(equalToConstant: constraintValue)
            containerViewWidthConstraint?.isActive = true
        } else {
            containerViewWidthConstraint?.constant = constraintValue
        }
    }

}
