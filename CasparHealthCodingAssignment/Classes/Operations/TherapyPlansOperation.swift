//
//  TherapyPlansOperation.swift
//  CasparHealth
//
//  Created by Gennadii Berezovskii on 18.09.18.
//  Copyright © 2018 GOREHA GmbH. All rights reserved.
//

import GBAsyncOperation

class TherapyPlansOperation: GBAsyncOperation {
    
    var completion: (CasparResult<TherapyWeek>) -> Void
    
    var therapyPlans: [TherapyPlan]?
    var contentCollection = TherapyWeek(exercises: [])
    
    init(completion: @escaping (CasparResult<TherapyWeek>) -> Void) {
        self.completion = completion
    }
    
    override func main() {
        fetchTherapyWeek()
    }
    
    // MARK: Fetch Methods
    
    func fetchTherapyWeek() {
        guard !isCancelled else {
            return
        }
        
        CasparAPIClient.fetchTherapyPlans { (response) in
            switch response {
            case .success(let dataTaskCompletion):
                do {
                    let plans = try JSONDecoder().decode(TherapyPlanCollection.self, from: dataTaskCompletion.data!)
                    self.handleTherapyPlansLoaded(plans)
                } catch let error {
                    Log.error("Couldn't decode TherapyPlanCollection: \(error)")
                    self.failOperation(CasparError(domain: .therapyWeek, code: .serializationError, description: error.localizedDescription))
                }
            case .failure(let error, _):
                self.failOperation(error)
            }
        }
    }
    
    func fetchTherapyPlanWith(identificator: Int) {
        guard !isCancelled else {
            return
        }
        
        CasparAPIClient.fetchTherapyPlanWith(identifier: identificator) { (response) in
            switch response {
            case .success(let dataTaskCompletion):
                do {
                    let therapyPlan = try JSONDecoder().decode(TherapyPlan.self, from: dataTaskCompletion.data!)
                    self.handleTherapyPlanLoaded(therapyPlan)
                } catch {
                    Log.error("Couldn't decode TherapyPlan: \(error)")
                    self.failOperation(CasparError(domain: .therapyWeek, code: .serializationError, description: error.localizedDescription))
                }
                
            case .failure(let error, _):
                self.failOperation(error)
            }
        }
    }
    
    // MARK: Handle Methods
    
    func handleTherapyPlansLoaded(_ therapyPlans: TherapyPlanCollection) {
        guard !isCancelled else {
            return
        }
        
        guard let firstTherapyPlan = therapyPlans.executingTherapyPlans.first else {
            completeOperationWith(therapyWeek: TherapyWeek(exercises: []))
            return
        }
    
        self.therapyPlans = therapyPlans.executingTherapyPlans
        
        fetchTherapyPlanWith(identificator: firstTherapyPlan.id)
    }
    
    func handleTherapyPlanLoaded(_ therapyPlan: TherapyPlan) {
        guard !isCancelled else {
            return
        }
        
        let content = therapyPlan.content ?? []
        
        let therapyWeek = TherapyWeek(exercises: content, therapyPlan: therapyPlan)
        
        contentCollection.append(anotherTrainingDays: therapyWeek.trainingDays)
        if therapyPlan.isActive {
            contentCollection.activeTherapyPlan = therapyPlan
        }
        
        if let therapyPlans = therapyPlans,
            let currentPlanIndex = therapyPlans.firstIndex(where: { $0.id == therapyPlan.id }),
            currentPlanIndex + 1 < therapyPlans.count {
            let nextTherapyPlan = therapyPlans[currentPlanIndex + 1]
            fetchTherapyPlanWith(identificator: nextTherapyPlan.id)
        } else {
            completeOperationWith(therapyWeek: contentCollection)
        }
    }
    
    // MARK: Completion methods
    
    func completeOperationWith(therapyWeek: TherapyWeek) {
        guard !isCancelled else {
            return
        }
        
        completion(.success(therapyWeek))
        finish()
    }
    
    func failOperation(_ error: Error) {
        guard !isCancelled else {
            return
        }
        
        Log.error(error)
        
        completion(.failure(error))
        finish()
    }
    
}
