//
//  CasparError.swift
//  CH_PatientApp
//
//  Created by Gennadii Berezovskii on 03.12.19.
//  Copyright © 2019 GOREHA GmbH. All rights reserved.
//

import Foundation
import Alamofire

enum CasparErrorDomain: String {
    case pushNotifications
    case login
    case therapyWeek
    case myTrainingInfo
    case videoPlayer
    case networking
    case chatSDK
    case authentication
    case unknown
}

enum CasparErrorCode: Int {
    case newAuthInvalidCredentials = 401
    case serializationError = 600
    case invalidCredentials = 601
    case noData = 602
    case noResponse = 603
    case tokenInvalid = 604
    case other = 878
}

public class CasparError: NSError {
    
    static var rechabilityManager = NetworkReachabilityManager()
    
    var isNetworkUnreachable: Bool {
        if let manager = CasparError.rechabilityManager {
            return !manager.isReachable
        }
        
        return false
    }
    
    var isNetworkTimeout: Bool {
        return code == HTTPStatusCode.networkTimeout.rawValue
    }
    
    var isSerializationError: Bool {
        return code == CasparErrorCode.serializationError.rawValue
    }
    
    var isNotAuthorised: Bool {
        return code == HTTPStatusCode.notAuthorised.rawValue
    }
    
    convenience init(domain: CasparErrorDomain = .unknown, code: Int, description: String) {
        self.init(domain: domain.rawValue, code: code, userInfo: [NSLocalizedDescriptionKey : description])
    }
    
    convenience init(domain: CasparErrorDomain = .unknown, code: CasparErrorCode = .other, description: String) {
        self.init(domain: domain.rawValue, code: code.rawValue, userInfo: [NSLocalizedDescriptionKey : description])
    }
    
}
