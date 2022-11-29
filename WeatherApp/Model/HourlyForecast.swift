//
//  HourlyForecast.swift
//  WeatherApp
//
//  Created by Frédéric Helfer on 29/11/22.
//

import Foundation

/*
 URL:
 https://pro.openweathermap.org/data/2.5/forecast/hourly?lat={lat}&lon={lon}&appid={API key}
 https://api.openweathermap.org/data/2.5/forecast?lat=-29.737&lon=-52.4487&appid=38ec62852779e6ad30a064b9e15e9bff&units=metric
 
 RESPONSE:
 
 {
 "dt": 1669734000,
 "main": {
 "temp": 25.96,
 "feels_like": 25.96,
 "temp_min": 25.96,
 "temp_max": 29.68,
 "pressure": 1010,
 "sea_level": 1010,
 "grnd_level": 999,
 "humidity": 54,
 "temp_kf": -3.72
 },
 "weather": [
 {
 "id": 801,
 "main": "Clouds",
 "description": "few clouds",
 "icon": "02d"
 }
 ],
 "clouds": {
 "all": 20
 },
 "wind": {
 "speed": 2.89,
 "deg": 99,
 "gust": 3.41
 },
 "visibility": 10000,
 "pop": 0,
 "sys": {
 "pod": "d"
 },
 "dt_txt": "2022-11-29 15:00:00"
 }
 
 */

struct HourlyForecast: Codable {
    let list: [List]
}

struct List: Codable {
    let main: Main?
    let weather: [Weather]?
    let clouds: Clouds?
    let hour: String?
}
