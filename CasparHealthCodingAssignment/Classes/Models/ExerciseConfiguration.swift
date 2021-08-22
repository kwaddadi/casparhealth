//
//  ExerciseConfiguration.swift
//  CasparHealth
//
//  Created by Rui Miguel on 12.10.17.
//  Copyright © 2017 GOREHA GmbH. All rights reserved.
//

import Foundation

struct ExerciseConfiguration: Decodable {
    let id: Int // API parameter "exercise_id" ignored
    let title: String
    let videoURLs: VideoAddresses
    let audioURLs: AudioAddresses
    let localisedAudioURL: URL? // Matched by the backend for the lang parameter sent with the request
    let description: String
    let instructions: String
    let noteFromTherapist: String
    let kind: Kind
    let totalDuration: Int // in seconds
    let totalMinutesDuration: Int // in minutes
    let categories: [Int]
    
    enum CodingKeys: String, CodingKey {
        case videoURLs = "video_urls"
        case audioURLs = "audio_urls"
        case description = "introduction" // Description maps to "introduction" from API
        case instructions = "instruction"
        case totalDuration = "duration"
        // Will be used in a nested structure, but obtained from API's top level response
        case exerciseType = "exercise_type"
        case executionType = "execution_type"
        case setCount = "sets_count"
        case repetitionCount = "repetitions_count"
        case repetitionDuration = "repetition_duration"
        case totalMinutesDuration = "total_task_duration"
        case pauseBetweenSets = "sets_pause"
        case holdDuration = "repetitions_hold"
        case noteFromTherapist = "extra_note"
        case localisedAudioURL = "localised_audio"
        // These match naming and casing from the API
        case title
        case id
        case kind
        case categories = "category_ids"
    }
    
    // swiftlint:disable:next cyclomatic_complexity function_body_length
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // Keys
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String?.self, forKey: .title) ?? " "
        let videoURLs = try container.decode(VideoAddresses.self, forKey: .videoURLs)
        self.videoURLs = videoURLs
        self.audioURLs = try container.decode(AudioAddresses.self, forKey: .audioURLs)
        self.localisedAudioURL = try container.decode(URL?.self, forKey: .localisedAudioURL)
        self.description = try container.decode(String?.self, forKey: .description) ?? ""
        
        let noInstructionsProvidedString = NSLocalizedString("No instructions provided.",
                                                             comment: "Text to display in the instructions field inside the exercise preview screen")
        self.instructions = try container.decode(String?.self, forKey: .instructions) ?? noInstructionsProvidedString
        self.totalDuration = try container.decode(Int?.self, forKey: .totalDuration) ?? 0 // Workaround CH-3942
        self.totalMinutesDuration = try container.decode(Int.self, forKey: .totalMinutesDuration)
        self.noteFromTherapist = try container.decode(String?.self, forKey: .noteFromTherapist) ?? ""
        self.categories = try container.decode([Int].self, forKey: .categories)
        let kindString = try container.decode(String.self, forKey: .kind)
        switch kindString {
        case "exercise":
            let exerciseType = try container.decode(String.self, forKey: .exerciseType)
            let exercise: Kind.ExerciseType
            let details: ExerciseConfigurationDetails
            // Used in two of the 3 exercise types
            let sets = try container.decode(Int.self, forKey: .setCount)
            let pause = try container.decode(Int.self, forKey: .pauseBetweenSets)
            let repetitionCount = try container.decode(Int.self, forKey: .repetitionCount)
            
            switch exerciseType {
            case "repetitions_and_sets":
                let repetitionDuration = try container.decode(Int.self, forKey: .repetitionDuration)
                exercise = .repetitionsAndSets
                details = ExerciseConfigurationDetails(setCount: sets, repetitionCount: repetitionCount, pauseBetweenSets: pause, repetitionDuration: repetitionDuration)
            case "time_based":
                guard totalDuration > 0 else {
                    throw "Total duration of an exercise is invalid"
                }
                details = ExerciseConfigurationDetails(setCount: sets, repetitionCount: repetitionCount, pauseBetweenSets: pause, repetitionDuration: totalDuration)
                exercise = .timeBased
            default:
                throw "exerciseType key did not return a known value"
            }
            
            let executionType = try container.decode(String.self, forKey: .executionType)
            let execution: Kind.Execution
            
            switch executionType {
            case "loop_and_speed":
                if let loopURL = videoURLs.loop {
                    execution = .loop(url: loopURL, canControlSpeed: true)
                } else {
                    execution = .noSync
                }
            case "loop_and_no_speed":
                if let loopURL = videoURLs.loop {
                    execution = .loop(url: loopURL, canControlSpeed: false)
                } else {
                    execution = .noSync
                }
            case "not_synchronized":
                execution = .noSync
            default:
                throw "executionType key did not return a known value"
            }
            self.kind = .exercise(type: exercise, details: details, execution: execution)
            
        case "education":
            self.kind = .resource
        default:
            throw "Unrecognised value for key: kind"
        }
    }
    
    struct VideoAddresses: Decodable {
        private let original: URL // Might contain a format not supported by AVPlayer
        let mp4: URL
        fileprivate let loop: URL? // Only usable from Execution type, if case is loop
        let thumbnail: URL
        
        enum CodingKeys: String, CodingKey { // swiftlint:disable:this nesting
            case thumbnail = "thumb"
            // These match naming and casing from the API
            case original
            case mp4
            case loop
        }
    }
    
    enum Kind {
        case exercise(type: ExerciseType, details: ExerciseConfigurationDetails, execution: Execution)
        case resource
        
        enum ExerciseType { // swiftlint:disable:this nesting
            case repetitionsAndSets
            case timeBased
        }
        
        enum Execution { // swiftlint:disable:this nesting
            case loop(url: URL, canControlSpeed: Bool)
            case noSync
        }
        
    }
    
    struct ExerciseConfigurationDetails {
        let setCount: Int
        let repetitionCount: Int
        let pauseBetweenSets: Int
        let repetitionDuration: Int
    }
    
}
