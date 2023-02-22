//
//  WeatherIcon.swift
//  WeatherApp
//
//  Created by Frédéric Helfer on 21/02/23.
//

import Foundation

enum weatherIcon: String, Codable {
    case clearSky = "01d"
    case clearSkyN = "01n"
    case fewClouds = "02d"
    case fewCloudsN = "02n"
    case scatteredClouds = "03d"
    case scatteredCloudsN = "03n"
    case brokenClouds = "04d"
    case brokenCloudsN = "04n"
    case showerRain = "09d"
    case showerRainN = "09n"
    case rain = "10d"
    case rainN = "10n"
    case thunderstorm = "11d"
    case thunderstormN = "11n"
    case snow = "13d"
    case snowN = "13n"
    case mist = "50d"
    case mistN = "50n"
    
    
    var text: String {
        switch self {
        case .clearSky: return "sun.max.fill"
        case .clearSkyN: return "moon.stars.fill"
        case .fewClouds: return "cloud.sun.fill"
        case .fewCloudsN: return "cloud.moon.fill"
        case .scatteredClouds: return "cloud.fill"
        case .scatteredCloudsN: return "cloud.fill"
        case .brokenClouds: return "smoke.fill"
        case .brokenCloudsN: return "smoke.fill"
        case .showerRain: return "cloud.rain.fill"
        case .showerRainN: return "cloud.rain.fill"
        case .rain: return "cloud.sun.rain.fill"
        case .rainN: return "cloud.moon.rain.fill"
        case .thunderstorm: return "cloud.bolt.rain.fill"
        case .thunderstormN: return "cloud.bolt.rain.fill"
        case .snow: return "snowflake"
        case .snowN: return "snowflake"
        case .mist: return "aqi.low"
        case .mistN: return "aqi.low"
        }
    }
}
