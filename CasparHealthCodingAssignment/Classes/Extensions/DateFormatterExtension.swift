//
//  DateFormatterExtension.swift
//  CasparHealth
//
//  Created by Gennady Berezovsky on 05.06.18.
//  Copyright © 2018 GOREHA GmbH. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    // A formatter predefined with API yyyy-MM-dd date format
    static var apiDateFormatter: DateFormatter = {
        $0.dateFormat = API.DateFormat.yearMonthDay
        return $0
    }(DateFormatter())
    
    static var apiDateFormatterISO8601: DateFormatter = {
        $0.dateFormat = API.DateFormat.ISO8601
        return $0
    }(DateFormatter())
    
    static var trackingDateFormatter: DateFormatter = {
        $0.dateFormat = API.DateFormat.ISO8601
        $0.timeZone = TimeZone(secondsFromGMT: 0)
        return $0
    }(DateFormatter())
    
    static var messagesFeedDateFormatter: DateFormatter = {
        $0.dateStyle = .short
        $0.timeStyle = .short
        return $0
    }(DateFormatter())
    
}
