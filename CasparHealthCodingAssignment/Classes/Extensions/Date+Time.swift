//
//  Date+Time.swift
//  CH_PatientApp
//
//  Created by Rui Miguel on 14/2/17.
//  Copyright © 2017 GOREHA GmbH. All rights reserved.
//

import Foundation

extension Date {
    
    /// Returns the same date at midnight in the user's time zone
    var startOfDay: Date {
        let calendar = Calendar.current
        return calendar.startOfDay(for: self)
    }
    
    func utcMilliseconds() -> Int64 {
        return Int64(timeIntervalSince1970 * 1000.0)
    }
    
    /// Calculates time passed with the given parameters
    /// - Parameters:
    ///   - component: Component of a calender date
    ///   - date: Date to calculate the time passed since then
    /// - Returns: Time passed in provided component unit from the specified date to object's date
    func time(in component: Calendar.Component, since date: Date) -> Int? {
        let dateComponents = Calendar.current.dateComponents(
            [component],
            from: date,
            to: self)
        return dateComponents.value(for: component)
    }
}
