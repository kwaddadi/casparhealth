//
//  CasparAPIClient.swift
//  CasparHealth
//
//  Created by Kris George Manimala on 18.04.18.
//  Copyright © 2018 GOREHA GmbH. All rights reserved.
//

import Foundation
import Alamofire

typealias JSONObject = [String: Any]

class CasparAPIClient {
    
    static func fetchTherapyPlans(completion: @escaping (APIResponse.APIClientResponseCallBack<DataResponse<Any>>) -> Void) {
        BaseAPIClient.sharedInstance.performAPIRequest(apiRouterObject: APIRouter.therapyPlansList) { response in
            completion(response)
        }
    }
    
    static func fetchTherapyPlanWith(identifier: Int, completion: @escaping (APIResponse.APIClientResponseCallBack<DataResponse<Any>>) -> Void) {
        BaseAPIClient.sharedInstance.performAPIRequest(apiRouterObject: APIRouter.therapyPlan(identifier: identifier)) { response in
            completion(response)
        }
    }
    
    static func fetchExerciseCategories(completion: @escaping (APIResponse.APIClientResponseCallBack<DataResponse<Any>>) -> Void) {
        BaseAPIClient.sharedInstance.performAPIRequest(apiRouterObject: APIRouter.exerciseCategories) { response in
            completion(response)
        }
    }
    
    static func fetchExerciseConfigWith(id exerciseId: Int, completion: @escaping (APIResponse.APIClientResponseCallBack<DataResponse<Any>>) -> Void) {
        BaseAPIClient.sharedInstance.performAPIRequest(apiRouterObject: APIRouter.exerciseConfig(identifier: exerciseId)) { response in
            completion(response)
        }
    }

}
