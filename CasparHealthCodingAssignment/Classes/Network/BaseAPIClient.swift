//
//  APIClient.swift
//  CasparHealth
//
//  Created by Kris George Manimala on 10.04.18.
//  Copyright © 2018 GOREHA GmbH. All rights reserved.
//

import Foundation
import Alamofire

/// Base API client singleton
final class BaseAPIClient {
    
    /// Shared instance of BaseAPIClient
    static var sharedInstance = BaseAPIClient()
    
    /// Makes API call by creating an API operation
    /// - Parameters:
    ///   - apiRouterObject: A request object of API router
    ///   - completion: Completion block
    func performAPIRequest(apiRouterObject: APIRouter, completion: @escaping (APIResponse.APIClientResponseCallBack<DataResponse<Any>>) -> Void) {
        
        let response = responseFromFile(for: apiRouterObject)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + apiRouterObject.latency) {
            completion(response)
        }
        
    }
    
    /// Mocks API call response by loading it from json file
    /// - Parameters:
    ///   - apiRouterObject: A request object of API router
    private func responseFromFile(for apiRouterObject: APIRouter) -> APIResponse.APIClientResponseCallBack<DataResponse<Any>> {
        guard let fileURL = Bundle.main.url(forResource: apiRouterObject.path, withExtension: "json"),
              let data = try? Data(contentsOf: fileURL) else {
            let dataResponse = DataResponse<Any>(request: nil, response: nil, data: nil, result: .failure(""))
            let description = "No mock response file for route \(apiRouterObject.path)"
            print(description)
            return .failure(CasparError(domain: .networking, code: 678, description: description), dataResponse)
        }
        
        let dataResponse = DataResponse<Any>(request: nil, response: nil, data: data, result: .success(data))
        return .success(dataResponse)
    }

}
