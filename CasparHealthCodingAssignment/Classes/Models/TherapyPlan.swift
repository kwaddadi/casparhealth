//
//  TrainingPlan.swift
//  CasparHealth
//
//  Created by Rui Miguel on 12.10.17.
//  Copyright © 2017 GOREHA GmbH. All rights reserved.
//

import Foundation

struct TherapyPlanCollection : Decodable {
    
    enum CodingKeys: String, CodingKey {
        case collection
    }
    
    var collection: [TherapyPlan]
    
    var executingTherapyPlans: [TherapyPlan] {
        return collection.filter({ $0.isActive })
    }

}

enum TherapyPlanState: String, Decodable {
    case executing
    case other
}

struct TherapyPlan : Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case startDateString = "start_date"
        case content = "exercise_days"
        case isFeedbackAllowed = "feedback"
        case state
        case weekNumber = "week_num"
        case activityItemTasks = "activity_item_tasks"
    }
    
    var id: Int
    var startDateString: String
    var isFeedbackAllowed: Bool
    var state: TherapyPlanState = .other
    var weekNumber: Int?
    
    var isActive: Bool {
        return state == .executing
    }
    
    var content: [Exercise]?
    
    var exercises: [Exercise]? {
        return content?.filter({ $0.isExercise })
    }
    var resources: [Exercise]? {
        return content?.filter({ $0.kind == .resource })
    }
    
    let apiDateFormatter = DateFormatter.apiDateFormatter
    
    var startDate: Date {
        return self.apiDateFormatter.date(from: self.startDateString)!
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try values.decode(Int.self, forKey: .id)
        self.startDateString = try values.decode(String.self, forKey: .startDateString)
        self.isFeedbackAllowed = try values.decode(Bool.self, forKey: .isFeedbackAllowed)
        self.weekNumber = try? values.decode(Int.self, forKey: .weekNumber)
        if let state = try? values.decode(TherapyPlanState.self, forKey: .state) {
            self.state = state
        }
        
        guard values.contains(.content), let content = try values.decodeIfPresent([Exercise].self, forKey: .content) else {
            return
        }
        
        let array = content.map { (exercise) -> Exercise in
            var newExercise = exercise
            newExercise.isFeedbackAllowed = self.isFeedbackAllowed
            return newExercise
        }
        self.content = array

    }
    
}
