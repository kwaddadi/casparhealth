//
//  APIRouter.swift
//  CasparHealth
//
//  Created by Kris George Manimala on 10.04.18.
//  Copyright © 2018 GOREHA GmbH. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter {
    
    case therapyPlansList
    case therapyPlan(identifier: Int)
    case exerciseCategories
    case exerciseConfig(identifier: Int)
    
    var path: String {
        switch self {
        case .therapyPlansList:
            return "therapy_plans"
        case .therapyPlan(let identifier):
            return "therapy_plans_\(identifier)"
        case .exerciseCategories:
            return "exercise_categories"
        case .exerciseConfig(let identifier):
            return "exercise_configs_\(identifier)"
        }
    }
    
    // This var is a task precondition, please don't change it
    var latency: Double {
        switch self {
        case .therapyPlansList:
            return Double.random(in: 0.3...1)
        case .therapyPlan:
            return Double.random(in: 0.5...1.2)
        case .exerciseCategories:
            return Double.random(in: 10...20)
        case .exerciseConfig:
            return Double.random(in: 0.5...1)
        }
    }

}
