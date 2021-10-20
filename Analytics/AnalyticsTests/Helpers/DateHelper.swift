//
//  DateHelper.swift
//  AnalyticsTests
//
//  Created by Deniz Tutuncu on 10/20/21.
//

import Foundation

internal class DateHelper {
    private init() { }
    
    static func fixedDate() -> Date {
        return createConstantDate(DateHelper.createFixedDateComponents())
    }
    
    static func createConstantDate(_ fromComponents: DateComponents) -> Date {
        let userCalendar = Calendar(identifier: .gregorian)
        let constDate = userCalendar.date(from: fromComponents)
        return constDate!
    }
    
    static func createFixedDateComponents() -> DateComponents {
        var dateComponents = DateComponents()
        dateComponents.year = 2021
        dateComponents.month = 9
        dateComponents.day = 3
        dateComponents.timeZone = TimeZone(abbreviation: "PST") // Pacific Standard Time
        dateComponents.hour = 01
        dateComponents.minute = 00
        
        return dateComponents // Sept 3, 2021
    }
}
