//
//  ExerciseCategoriesCollection.swift
//  CasparHealth
//
//  Created by Gennady Berezovsky on 15.06.18.
//  Copyright © 2018 GOREHA GmbH. All rights reserved.
//

import Foundation

enum ExerciseCategoryCode: String {
    case equipment
}

struct ExerciseCategoriesCollection: Codable {

    enum CodingKeys: String, CodingKey {
        case collection
    }
    
    static let noEquipmentTag = NSLocalizedString("ExerciseInfo_NoEquipment_Tag", comment: "")
    static let noEquipmentTagLong = NSLocalizedString("ExerciseInfo_NoEquipment_TagLong", comment: "")
    
    var collection: [ExerciseCategory] = []
    
    static func isEmptyEquipmentList(_ list: [String]) -> Bool {
        return list == [noEquipmentTag]
    }
    
    func categoryWithCode(_ code: ExerciseCategoryCode) -> ExerciseCategory? {
        return self.collection.filter { $0.code == code.rawValue }.first
    }
    
    func equipmentListFor(exercises: [Exercise]) -> [String] {
        guard let equipmentCategory = self.categoryWithCode(.equipment) else {
            return [ExerciseCategoriesCollection.noEquipmentTag]
        }
        
        let result = exercises.map { (exercise) in
            return equipmentCategory.children
                .filter { exercise.categories.contains($0.id) }
                .map { return $0.title }
            }.flatMap { $0 }
        return result.isEmpty ? [ExerciseCategoriesCollection.noEquipmentTag] : Array(Set(result))
    }
    
    func equipmentListFor(exerciseConfiguration: ExerciseConfiguration) -> [String] {
        guard let equipmentCategory = self.categoryWithCode(.equipment) else {
            return [ExerciseCategoriesCollection.noEquipmentTag]
        }
        
        let result = equipmentCategory.children
            .filter { exerciseConfiguration.categories.contains($0.id) }
            .map { return $0.title }
        
        return result.isEmpty ? [ExerciseCategoriesCollection.noEquipmentTag] : result
    }
    
}

struct ExerciseCategory: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case code
        case children
    }
    
    let id: Int
    let title: String
    let code: String
    let children: [ExerciseCategory]

}
