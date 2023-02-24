//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Frédéric Helfer on 20/02/23.
//

import Foundation

struct CurrentWeather: Codable, Identifiable {
    let id: Int
    let cod: Int
    let name: String
    let coord: Coord
    let main: Main
    let weather: [Weather]
//    let base: String?
//    let visibility: Int?
//    let wind: Wind?
//    let rain: Rain?
//    let clouds: Clouds?
//    let dt: Int?
//    let sys: Sys? // - have sunrise and sunset
//    let timezone: Int?
}

struct Coord: Codable {
    let lon, lat: Double?
}

struct Weather: Codable {
    let id: Int?
    let main: String?
    let description: String?
    let icon: weatherIcon?
}

struct Main: Codable {
    let temp: Double?
    let feelsLike: Double?
    let tempMin: Double?
    let tempMax: Double?
    let pressure: Int?
    let humidity: Int?
    let seaLevel: Int?
    let grndLevel: Int?
}

//struct Wind: Codable {
//    let speed: Double?
//    let deg: Int?
//    let gust: Double?
//}
//
//struct Rain: Codable {
//    let the1H: Double?
//
//    enum CodingKeys: String, CodingKey {
//        case the1H = "1h"
//    }
//}
//
//struct Clouds: Codable {
//    let all: Int?
//}
//
//struct Sys: Codable {
//    let type: Int?
//    let id: Int?
//    let country: String?
//    let sunrise: Int?
//    let sunset: Int?
//}

