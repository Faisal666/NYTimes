//
//  Extensions+Date.swift
//  NYTimes
//
//  Created by Faisal AlSaadi on 2/26/24.
//

import Foundation

extension String {
    func timeAgo() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")

        guard let date = dateFormatter.date(from: self) else {
            return "Invalid date"
        }

        let calendar = Calendar.current
        let now = Date()
        let components = calendar.dateComponents([.day, .weekOfYear], from: date, to: now)

        let weeks = components.weekOfYear ?? 0
        let days = components.day ?? 0 - (weeks * 7)

        var result = ""

        if weeks > 0 {
            result += "\(weeks) week" + (weeks > 1 ? "s" : "")
        }

        if days > 0 {
            if !result.isEmpty { result += " and " }
            result += "\(days) day" + (days > 1 ? "s" : "")
        }

        if result.isEmpty {
            return "Today"
        } else {
            return result + " ago"
        }
    }
}
