//
//  Location.swift
//  WeatherApp
//
//  Created by Frédéric Helfer on 21/02/23.
//

import Foundation

struct Location: Identifiable {
    var id = UUID()
    var cityName: String = ""
    var lat: Double = 0.0
    var lon: Double = 0.0
    let language: String = Locale.preferredLanguages.first?.lowercased().replacingOccurrences(of: "-", with: "_") ?? "en"
}
