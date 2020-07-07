//
//  Extensions+Date.swift
//  AmadaMachines
//
//  Created by IT Support on 11/11/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import Foundation

extension Date {

    func toString(format: String = "MMM dd, yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

    func getFormattedDate(format: String = "MMM dd, yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

    func toDateTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter.string(from: self)
    }
}

extension TimeInterval {

    func getFormattedDate(format: String = "MMM dd, yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: Date(timeIntervalSince1970: self))
    }
}

extension String {

    func toDateTime() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        dateFormatter.calendar = Calendar.current
        return dateFormatter.date(from: self)
    }

    func toDate(_ format: String = "yyyy-MM-dd") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        dateFormatter.calendar = Calendar.current
        return dateFormatter.date(from: self)
    }

    func getDate(_ format: String = "yyyy-MM-dd") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        dateFormatter.calendar = Calendar.current
        return dateFormatter.date(from: self)
    }

}
