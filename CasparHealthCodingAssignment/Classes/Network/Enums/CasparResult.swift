//
//  CasparResult.swift
//  CH_PatientApp
//
//  Created by Abdullah Bayraktar on 24.08.20.
//  Copyright © 2020 GOREHA GmbH. All rights reserved.
//

enum CasparResult<T> {
    case success(T)
    case failure(Error)
}
