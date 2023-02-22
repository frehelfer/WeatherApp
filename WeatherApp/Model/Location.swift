//
//  Location.swift
//  WeatherApp
//
//  Created by Frédéric Helfer on 21/02/23.
//

import Foundation

struct Location {
    let lat: Double
    let lon: Double
    let language: String = Locale.preferredLanguages.first?.lowercased().replacingOccurrences(of: "-", with: "_") ?? "en"
}
