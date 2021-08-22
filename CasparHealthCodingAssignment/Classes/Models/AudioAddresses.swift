//
//  ContentVideo.swift
//  CH_PatientApp
//
//  Created by Gennadii Berezovskii on 17.07.19.
//  Copyright © 2019 GOREHA GmbH. All rights reserved.
//

import Foundation

struct AudioAddresses: Codable {
    let english: URL?
    let german: URL?
    let chineseSimplified: URL?
    let chineseTraditional: URL?
    var availableLanguageURLs: [URL] {
        return [english, german, chineseSimplified, chineseTraditional]
            // Only include those which are not nil
            .compactMap { $0 }
    }
    
    enum CodingKeys: String, CodingKey {
        case english = "en"
        case german = "de"
        case chineseSimplified = "cn"
        case chineseTraditional = "zh"
    }
}
