//
//  ExerciseCategoriesOperation.swift
//  CasparHealth
//
//  Created by Gennadii Berezovskii on 18.09.18.
//  Copyright © 2018 GOREHA GmbH. All rights reserved.
//

import GBAsyncOperation

class ExerciseCategoriesOperation: GBAsyncOperation {
    
    var completion: (CasparResult<ExerciseCategoriesCollection>) -> Void
    
    init(completion: @escaping (CasparResult<ExerciseCategoriesCollection>) -> Void) {
        self.completion = completion
    }
    
    override func main() {
        CasparAPIClient.fetchExerciseCategories(completion: { (result) in
            switch result {
            case .success(let dataTaskCompletion):
                guard let jsonData = dataTaskCompletion.data,
                    let exerciseCategoriesCollection = try? JSONDecoder().decode(ExerciseCategoriesCollection.self, from: jsonData) else {
                        return
                }
                
                self.completeOperation(exerciseCategoriesCollection)
            case .failure(let error, _):
                self.failOperation(error)
            }
        })
    }
    
    func completeOperation(_ exerciseCategoriesCollection: ExerciseCategoriesCollection) {
        guard !isCancelled else {
            return
        }
        
        completion(.success(exerciseCategoriesCollection))
        finish()
    }
    
    func failOperation(_ error: CasparError) {
        guard !isCancelled else {
            return
        }
        
        completion(.failure(error))
        finish()
    }
    
}
