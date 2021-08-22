//
//  Log.swift
//  CH_PatientApp
//
//  Created by Rui Miguel on 11/2/17.
//  Copyright © 2017 GOREHA GmbH. All rights reserved.
//

import Foundation

struct Log {
    
    static func error(_ error: Error) {
        #if DEBUG
        print(error)
        #else
        // Send a log to the analytics
        #endif
    }
    
    static func message(_ msg: String) {
        #if DEBUG
            print(msg)
        #endif
    }
}

extension String: LocalizedError {
    public var errorDescription: String? { return self }
}
