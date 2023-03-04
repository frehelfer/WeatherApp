//
//  Location.swift
//  WeatherApp
//
//  Created by Frédéric Helfer on 21/02/23.
//

import Foundation

struct Location: Identifiable {
    var id = UUID().uuidString
    var weatherID: Int = 0
    var cityName: String = ""
    var lat: Double = 0.0
    var lon: Double = 0.0
}
