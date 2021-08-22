//
//  Exercise.swift
//  CasparHealth
//
//  Created by Gennady Berezovsky on 04.06.18.
//  Copyright © 2018 GOREHA GmbH. All rights reserved.
//

import Foundation

enum Kind: String, Codable {
    case exercise = "exercise"
    case resource = "education"
}

struct Exercise : Codable {
    
    enum CodingKeys: String, CodingKey {
        case configurationId = "exercise_config_id"
        case kind = "exercise_kind"
        case sessionNumber = "session_number"
        case titlePrivate = "title"
        case duration
        case totalMinutesDuration = "total_task_duration" // in minutes
        case thumbnailURL = "thumbnail_url"
        case dateString = "date"
        case status
        case id = "exercise_id"
        case categories = "category_ids"
        case notePrivate = "exercise_note"
    }
    
    let id: Int
    let configurationId: Int
    let kind: Kind?
    let sessionNumber: Int
    let titlePrivate: String?
    let notePrivate: String?
    let duration: Int // Seconds
    let totalMinutesDuration: Int // Minutes
    let thumbnailURL: URL
    let dateString: String
    let categories: [Int]
    
    let status: Status
    
    var title: String {
        return titlePrivate ?? NSLocalizedString("Exercise_NoTitle", comment: "")
    }
    
    var note: String {
        return notePrivate ?? NSLocalizedString("Exercise_NoSubtitle", comment: "")
    }
    
    var isFeedbackAllowed: Bool = false
    
    var isExercise: Bool {
        return kind == .exercise || kind == nil
    }
    
    var isCompleted: Bool {
        return status == .completed
    }
    
    var isActive: Bool {
        return status == .active
    }
    
    let apiDateFormatter = DateFormatter.apiDateFormatter
    
    var date: Date {
        return self.apiDateFormatter.date(from: self.dateString)!
    }
    
    enum Status: String, Codable {
        case active, missed, completed, pending, aborted
    }

}
