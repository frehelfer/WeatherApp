//
//  Double+.swift
//  WeatherApp
//
//  Created by Frédéric Helfer on 21/02/23.
//

import Foundation

extension Double {
    
    /// Converts a Double into string representation
    /// ```
    /// Convert 1.2345 to "1"
    /// ```
    func asStringRounded() -> String {
        return String(format: "%.0f", self)
    }
}
