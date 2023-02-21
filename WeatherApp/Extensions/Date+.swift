//
//  Date+.swift
//  WeatherApp
//
//  Created by Frédéric Helfer on 21/02/23.
//

import Foundation

extension Date {
    
    /// Converts a Date into string representation
    /// ```
    /// Convert Date to "5 AM"
    /// Convert Date to "5 PM"
    /// ```
    func asDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h a"
        return dateFormatter.string(from: self)
    }
}
