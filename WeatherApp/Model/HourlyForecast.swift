//
//  HourlyForecast.swift
//  WeatherApp
//
//  Created by Frédéric Helfer on 21/02/23.
//

import Foundation

struct HourlyForecast: Codable {
    let list: [List]
    let city: City?
}

struct List: Codable {
    let id = UUID()
    let main: Main?
    let weather: [Weather]?
    let clouds: Clouds?
    let hour: Date? // "2022-08-30 15:00:00"
    
    enum CodingKeys: String, CodingKey {
        case main, weather, clouds
        case hour = "dt_txt"
    }
    
    static let example = List(
        main: Main(temp: 27.54, feelsLike: 28.19, tempMin: 26.72, tempMax: 27.54, pressure: 1007, humidity: 53, seaLevel: 1007, grndLevel: 996),
        weather: [Weather(id: 802, main: "Clouds", description: "scattered clouds", icon: "03d")],
        clouds: Clouds(all: 29),
        hour: Date()
        )
}

struct City: Codable {
    let id: Int?
    let name: String?
    let coord: Coord?
    let country: String?
    let population: Int?
    let timezone: Int?
    let sunrise: Int?
    let sunset: Int?
}
