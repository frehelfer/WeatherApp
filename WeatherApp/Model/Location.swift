//
//  Location.swift
//  WeatherApp
//
//  Created by Frédéric Helfer on 21/02/23.
//

import Foundation

struct Location {
    let cityName: String = ""
    let lat: Double = 0.0
    let lon: Double = 0.0
    let language: String = Locale.preferredLanguages.first?.lowercased().replacingOccurrences(of: "-", with: "_") ?? "en"
}
