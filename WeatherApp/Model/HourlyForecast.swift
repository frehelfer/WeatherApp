//
//  HourlyForecast.swift
//  WeatherApp
//
//  Created by Frédéric Helfer on 21/02/23.
//

import Foundation

struct HourlyForecast: Codable {
    let list: [HourlyItem]
    
    static let example = HourlyForecast(list: [
        HourlyItem(
            main: Main(temp: 27.54, feelsLike: 28.19, tempMin: 26.72, tempMax: 27.54, pressure: 1007, humidity: 53, seaLevel: 1007, grndLevel: 996),
            weather: [Weather(id: 802, main: "Clouds", description: "scattered clouds", icon: .clearSky)],
            clouds: Clouds(all: 29),
            dtTxt: Date()
        ),
        HourlyItem(
            main: Main(temp: 27.54, feelsLike: 28.19, tempMin: 26.72, tempMax: 27.54, pressure: 1007, humidity: 53, seaLevel: 1007, grndLevel: 996),
            weather: [Weather(id: 802, main: "Clouds", description: "scattered clouds", icon: .clearSky)],
            clouds: Clouds(all: 29),
            dtTxt: Date()
        ),
        HourlyItem(
            main: Main(temp: 27.54, feelsLike: 28.19, tempMin: 26.72, tempMax: 27.54, pressure: 1007, humidity: 53, seaLevel: 1007, grndLevel: 996),
            weather: [Weather(id: 802, main: "Clouds", description: "scattered clouds", icon: .clearSky)],
            clouds: Clouds(all: 29),
            dtTxt: Date()
        ),
    ])
}

struct HourlyItem: Codable, Identifiable {
    let id = UUID()
    let main: Main?
    let weather: [Weather]
    let clouds: Clouds?
    let dtTxt: Date? // "2022-08-30 15:00:00"
    
    static let example = HourlyItem(
        main: Main(temp: 27.54, feelsLike: 28.19, tempMin: 26.72, tempMax: 27.54, pressure: 1007, humidity: 53, seaLevel: 1007, grndLevel: 996),
        weather: [Weather(id: 802, main: "Clouds", description: "scattered clouds", icon: .clearSky)],
        clouds: Clouds(all: 29),
        dtTxt: Date()
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
