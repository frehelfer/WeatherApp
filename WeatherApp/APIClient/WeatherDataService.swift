//
//  WeatherDataService.swift
//  WeatherApp
//
//  Created by Frédéric Helfer on 20/02/23.
//

import Foundation

// https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}
// &units=metric
// &lang=pt_br
// https://api.openweathermap.org/data/2.5/weather?lat=-29.737030&lon=-52.448650&appid=38ec62852779e6ad30a064b9e15e9bff&units=metric

class WeatherDataService: ObservableObject {
    
    private let apiKey = "38ec62852779e6ad30a064b9e15e9bff"
    private let units = "metric"
    
    init() {
        
    }
    
    public func fetchCurrentWeather(location: Location) async throws -> CurrentWeather {
        guard
            let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(location.lat)&lon=\(location.lon)&appid=\(apiKey)&units=\(units)&lang=\(location.language)") else {
            throw URLError(.badURL)
        }
        
//        print(url)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let currentWeather = try decoder.decode(CurrentWeather.self, from: data)
            return currentWeather
        } catch {
            throw URLError(.badServerResponse)
        }
    }
    
    public func fetchForecastWeather(location: Location) async throws -> HourlyForecast {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=\(location.lat)&lon=\(location.lon)&appid=\(apiKey)&units=\(units)&lang=\(location.language)") else {
            throw URLError(.badURL)
        }
//        print(url)
        
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // 2023-02-22 03:00:00
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let forecastWeather = try decoder.decode(HourlyForecast.self, from: data)
            return forecastWeather
        } catch {
            throw URLError(.badServerResponse)
        }
    }
}
