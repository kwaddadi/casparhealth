//
//  HTTPStatusCode.swift
//  CH_PatientApp
//
//  Created by Abdullah Bayraktar on 27.08.20.
//  Copyright © 2020 GOREHA GmbH. All rights reserved.
//

enum HTTPStatusCode: Int {
    case success
    case failure
    case notAuthorised = 401
    case forbidden = 403
    case networkTimeout = 418
    case serverFailure
    case unknown
    
    init(code: Int) {
        switch code {
        case 200...299: self = .success
        case 401: self = .notAuthorised
        case 403: self = .forbidden
        case 418: self = .networkTimeout
        case 400...499: self = .failure
        case 500...599: self = .serverFailure

        default: self = .unknown
        }
    }
}
