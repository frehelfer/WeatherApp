//
//  Weather.swift
//  CurrentWeatherApp
//
//  Created by Frédéric Helfer on 20/10/22.
//

import Foundation

// API
/*
 URL:
 https://api.openweathermap.org/data/2.5/weather?lat=13&lon=13&appid=38ec62852779e6ad30a064b9e15e9bff
 
 key:
 38ec62852779e6ad30a064b9e15e9bff
 
 Response:

 {
   "coord": {
     "lon": -52.4487,
     "lat": -29.737
   },
   "weather": [
     {
       "id": 802,
       "main": "Clouds",
       "description": "scattered clouds",
       "icon": "03d"
     }
   ],
   "base": "stations",
   "main": {
     "temp": 294.84,
     "feels_like": 294.92,
     "temp_min": 294.84,
     "temp_max": 294.84,
     "pressure": 1011,
     "humidity": 71,
     "sea_level": 1011,
     "grnd_level": 1001
   },
   "visibility": 10000,
   "wind": {
     "speed": 3.12,
     "deg": 84,
     "gust": 6.23
   },
   "clouds": {
     "all": 28
   },
   "dt": 1669720736,
   "sys": {
     "country": "BR",
     "sunrise": 1669710125,
     "sunset": 1669760071
   },
   "timezone": -10800,
   "id": 3450269,
   "name": "Santa Cruz do Sul",
   "cod": 200
 }

 */


struct CurrentWeather: Identifiable, Codable {
    let coord: Coord?
    let weather: [Weather]?
    let base: String?
    let main: Main?
    let visibility: Int?
    let wind: Wind?
    let rain: Rain?
    let clouds: Clouds?
    let dt: Int?
    let sys: Sys?
    let timezone: Int?
    let id: Int?
    let name: String?
    let cod: Int?
}

struct Coord: Codable {
    let lon, lat: Double?
}

struct Weather: Codable, Identifiable {
    let id: Int?
    let main, description, icon: String?
}

struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double?
    let pressure, humidity, seaLevel, grndLevel: Int?
}

struct Wind: Codable {
    let speed: Double?
    let deg: Int?
    let gust: Double?
}

struct Rain: Codable {
    let the1H: Double?

    enum CodingKeys: String, CodingKey {
        case the1H = "1h"
    }
}

struct Clouds: Codable {
    let all: Int?
}

struct Sys: Codable {
    let type, id: Int?
    let country: String?
    let sunrise, sunset: Int?
}
