//
//  TherapyWeek.swift
//  CH_PatientApp
//
//  Created by Gennadii Berezovskii on 18.04.19.
//  Copyright © 2019 GOREHA GmbH. All rights reserved.
//

import Foundation

struct TherapyWeek {
    
    var activeTherapyPlan: TherapyPlan?
    
    var trainingDays = [String : TrainingDay]()
    var trainingDaysSorted: [(String, TrainingDay)] {
        return trainingDays.sorted(by: { return $0.key < $1.key })
    }
    var content: [Exercise]
    var currentWeekNumber: Int {
        return activeTherapyPlan?.weekNumber ?? 0
    }
    
    var weekStartDate: Date {
        guard let activeTherapyPlan = activeTherapyPlan,
            let date = Calendar.current.date(byAdding: .weekOfYear, value: currentWeekNumber - 1, to: activeTherapyPlan.startDate) else {
            return Date()
        }
        return date
    }
    var weekEndDate: Date {
        let dateComponents = DateComponents(day: -1, weekOfYear: currentWeekNumber)
        guard let activeTherapyPlan = activeTherapyPlan,
            let date = Calendar.current.date(byAdding: dateComponents, to: activeTherapyPlan.startDate) else {
                return Date()
        }
        return date
    }
    
    var todayTraining: TrainingDay? {
        let selectedDayString = DateFormatter.apiDateFormatter.string(from: Date().startOfDay)
        return trainingDays[selectedDayString]
    }
    
    var availableExercises: [Exercise] {
        return content.filter({
            return $0.isExercise && $0.date <= Date().startOfDay
        })
    }
    
    var resources: [Exercise] {
        return trainingDaysSorted.flatMap { (_, trainingDay) -> [Exercise] in
            return trainingDay.resources
        }
    }
    
    var activeResources: [Exercise] {
        return resources.filter({
            return !$0.isCompleted
        })
    }
    
    var completedExercises: [Exercise] {
        return content.filter({
            return $0.isExercise && $0.isCompleted
        })
    }
    
    var completedResources: [Exercise] {
        return resources.filter({
            return $0.isCompleted
        })
    }
    
    var exercisesGroupedById: [Int : [Exercise]] {
        var exercisesDictionary = [Int : [Exercise]]()
        availableExercises.forEach { (exercise) in
            if let array = exercisesDictionary[exercise.id] {
                exercisesDictionary[exercise.id] = array + [exercise]
            } else {
                exercisesDictionary[exercise.id] = [exercise]
            }
        }
        return exercisesDictionary
    }
    
    init(exercises: [Exercise], therapyPlan: TherapyPlan? = nil) {
        self.content = exercises
        if let therapyPlan = therapyPlan, therapyPlan.isActive {
            self.activeTherapyPlan = therapyPlan
        }
        
        let sortedExercises = exercises.sorted { $0.isActive && !$1.isActive }
        
        for exercise in sortedExercises {
            if let existingTrainingDay = trainingDays[exercise.dateString] {
                var existingTrainingDay = existingTrainingDay
                existingTrainingDay.content.append(exercise)
                trainingDays[exercise.dateString] = existingTrainingDay
            } else {
                trainingDays[exercise.dateString] = TrainingDay(date: exercise.date, content: [exercise])
            }
        }
    }
    
    mutating func append(anotherTrainingDays: [String : TrainingDay]) {
        let exercisesArray = anotherTrainingDays.flatMap { (tuple) -> [Exercise] in
            let (_, exercises) = tuple
            return exercises.exercises
        }
        self.content.append(contentsOf: exercisesArray)
        
        trainingDays.merge(anotherTrainingDays, uniquingKeysWith: { (currentExercises, newExercises) -> TrainingDay in
            let jointArray = currentExercises.content + newExercises.content
            return TrainingDay(date: currentExercises.date, content: jointArray.sorted { $0.isActive && !$1.isActive })
        })
    }
    
}
