//
//  APIResponse.swift
//  CasparHealth
//
//  Created by Kris George Manimala on 23.04.18.
//  Copyright © 2018 GOREHA GmbH. All rights reserved.
//

import Foundation
import Alamofire

public class APIResponse {
    
    /// Generic enum to handle success/error handling
    public enum APIClientResponseCallBack<T> {
        case success(T)
        case failure(CasparError, T)
    }
    
    static func errorHandling(response: DataResponse<Any>) {
        // Received a notAuthorised response from the server (token expired, or something else), except during login (meaning invalid credentials)
        
        // Logout actions
    }
    
}
