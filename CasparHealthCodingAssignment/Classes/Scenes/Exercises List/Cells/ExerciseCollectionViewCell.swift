//
//  ExerciseCollectionViewCell.swift
//  CasparHealth
//
//  Created by Gennadii Berezovskii on 25.09.18.
//  Copyright © 2018 GOREHA GmbH. All rights reserved.
//

import UIKit

class ExerciseCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    @IBOutlet weak var sessionsIndicatorView: ExerciseSessionsIndicatorView!
    
    @IBOutlet weak var bottomSeparator: UIView!
    @IBOutlet weak var loadingView: UIView!
    
    var isLoading = false {
        didSet {
            loadingView.isHidden = !isLoading
            iconImageView.isHidden = isLoading
        }
    }
    
    var isCompleted = false {
        didSet {
            let iconImageName = isCompleted ? "icon-check-exercise" : "icon-play"
            iconImageView.image = UIImage(named: iconImageName)
            iconImageView.backgroundColor = isCompleted ? UIColor.exersiceListCompleted : UIColor.clear
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        thumbnailImageView.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        thumbnailImageView.layer.shadowRadius = 5.0
        thumbnailImageView.layer.shadowColor = UIColor.shadow.cgColor
        thumbnailImageView.layer.shadowOffset = .zero
        thumbnailImageView.layer.shadowOpacity = 0.7
    }
    
}
