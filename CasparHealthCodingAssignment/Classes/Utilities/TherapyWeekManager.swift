//
//  TherapyWeekManager.swift
//  CasparHealth
//
//  Created by Gennadii Berezovskii on 17.09.18.
//  Copyright © 2018 GOREHA GmbH. All rights reserved.
//

import UIKit

protocol TherapyWeekManagerNotificationCapable {
    
    func subscribeForTherapyWeekUpdate(handler: Selector)
    func unsubscribeForTherapyWeekUpdate()
    
}

extension TherapyWeekManagerNotificationCapable where Self: UIViewController {
    
    func subscribeForTherapyWeekUpdate(handler: Selector) {
        NotificationCenter.default.addObserver(self,
                                               selector: handler,
                                               name: Notification.Name.TherapyWeekOperationLoaded,
                                               object: nil)
    }
    
    func unsubscribeForTherapyWeekUpdate() {
        NotificationCenter.default.removeObserver(self,
                                                  name: Notification.Name.TherapyWeekOperationLoaded,
                                                  object: nil)
    }
    
}

class TherapyWeekManager {
    
    static let sharedInstance = TherapyWeekManager()
    
    var therapyWeek: TherapyWeek?
    var exerciseCategories: ExerciseCategoriesCollection?
    
    func therapyWeekOperation(completion: @escaping (CasparResult<TherapyWeek>) -> Void) -> TherapyWeekOperation {
        let operation = TherapyWeekOperation { (result) in
            switch result {
            case .success(let therapyWeek):
                self.therapyWeek = therapyWeek
                completion(.success(therapyWeek))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        return operation
    }
    
    func trainingDaysOperationWith(completion: @escaping (CasparResult<TherapyWeek>) -> Void) -> TherapyPlansOperation {
        let operation = TherapyPlansOperation { (result) in
            switch result {
            case .success(let therapyWeek):
                self.therapyWeek = therapyWeek
                completion(.success(therapyWeek))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        return operation
    }
    
}
