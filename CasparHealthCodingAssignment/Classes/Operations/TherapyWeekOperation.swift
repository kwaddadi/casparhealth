//
//  TherapyWeekOperation.swift
//  CH_PatientApp
//
//  Created by Gennadii Berezovskii on 18.04.19.
//  Copyright © 2019 GOREHA GmbH. All rights reserved.
//

import GBAsyncOperation

extension Notification.Name {
    
    static let TherapyWeekOperationLoaded = Notification.Name(rawValue: "TherapyWeekOperationLoadedNotificationName")
    
}

class TherapyWeekOperation: GBSerialGroupOperation {
    
    var completion: (CasparResult<(TherapyWeek)>) -> Void
    
    var therapyWeek: TherapyWeek?
    
    init(completion: @escaping (CasparResult<(TherapyWeek)>) -> Void) {
        self.completion = completion
        
        super.init(operations: [])
        
        setupOperations()
    }
    
    // MARK: - Fetch Methods
    
    func setupOperations() {
        let therapyPlansOperation = TherapyPlansOperation { (result) in
            switch result {
            case .success(let therapyWeek):
                self.therapyWeek = therapyWeek
            case .failure(let error):
                self.failOperation(error)
            }
        }
        
        addOperation(operation: therapyPlansOperation)
    }
    
    func completeOperation() {
        guard !isCancelled else {
            return
        }
        
        guard let therapyWeek = therapyWeek else {
            failOperation(CasparError(domain: .therapyWeek, code: .serializationError, description: "Some data wasn't loaded"))
            return
        }
        
        completion(.success(therapyWeek))
        NotificationCenter.default.post(name: Notification.Name.TherapyWeekOperationLoaded, object: nil, userInfo: nil)
        finish()
    }
    
    func failOperation(_ error: Error) {
        guard !isCancelled else {
            return
        }
        
        completion(.failure(error))
        finish()
    }
    
}
