//
//  ExerciseCollectionViewModel.swift
//  CasparHealth
//
//  Created by Gennadii Berezovskii on 25.09.18.
//  Copyright © 2018 GOREHA GmbH. All rights reserved.
//

import UIKit
import AlamofireImage

class ExerciseCollectionViewModel {

    var totalSessionsCount: Int = 0
    var completedSessionsCount: Int = 0
    var isLastInSection = false
    
    var hasSessionsToDo: Bool {
        return totalSessionsCount > completedSessionsCount
    }
    
    var exercise: Exercise
    
    init(exercise: Exercise, totalSessionsCount: Int, completedSessionsCount: Int) {
        self.exercise = exercise
        self.totalSessionsCount = totalSessionsCount
        self.completedSessionsCount = completedSessionsCount
    }
    
    func configure(cell: ExerciseCollectionViewCell) {
        cell.sessionsIndicatorView.totalCount = totalSessionsCount
        cell.sessionsIndicatorView.completedCount = completedSessionsCount
        
        cell.titleLabel.text = exercise.title
        cell.subtitleLabel.text = exercise.note
        
        cell.thumbnailImageView.af_setImage(withURL: exercise.thumbnailURL)
            
        cell.bottomSeparator.isHidden = isLastInSection
        cell.loadingView.isHidden = true
        
        cell.isCompleted = totalSessionsCount == completedSessionsCount
    }
    
}
