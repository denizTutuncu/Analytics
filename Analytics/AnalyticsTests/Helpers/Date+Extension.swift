//
//  Date+Extension.swift
//  AnalyticsTests
//
//  Created by Deniz Tutuncu on 10/20/21.
//

import Foundation

public extension Date {
    func convertToString() -> String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: self)
        guard let year = components.year, let month = components.month, let day = components.day else {
            return ""
        }
        return "\(year)-\(month)-\(day)"
    }
}
