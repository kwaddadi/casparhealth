//
//  TrainingDay.swift
//  CasparHealth
//
//  Created by Rui Miguel on 10.10.17.
//  Copyright © 2017 GOREHA GmbH. All rights reserved.
//

import Foundation

struct TrainingDay {
    
    let date: Date
    var content: [Exercise]
    
    var duration: Int {
        return self.activeExercises.map({ $0.duration }).reduce(0, +)
    }
    
    var totalMinutesDuration: Int {
        return self.activeExercises.map({ $0.totalMinutesDuration }).reduce(0, +)
    }
    
    var trainingCompleted: Bool {
        return exercises.count > 0 && activeExercises.count == 0
    }
    
    var exercises: [Exercise] {
        return content.filter({ $0.isExercise })
    }
    
    var resources: [Exercise] {
        return content.filter({ $0.kind == .resource })
    }
    
    var activeExercises: [Exercise] {
        return exercises.filter({ !$0.isCompleted })
    }
    
    init(date: Date, content: [Exercise]) {
        self.date = date
        self.content = content
    }
    
}
