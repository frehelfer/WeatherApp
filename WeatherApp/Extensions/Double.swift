//
//  Double.swift
//  WeatherApp
//
//  Created by Frédéric Helfer on 28/11/22.
//

import Foundation

extension Double {
    
    /// Converts a Double into string representation
    /// ```
    /// Convert 1.2345 to "1"
    /// ```
    func asNumberString() -> String {
        return String(format: "%.0f", self)
    }
}
