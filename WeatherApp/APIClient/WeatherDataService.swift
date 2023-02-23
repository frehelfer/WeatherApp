//
//  WeatherDataService.swift
//  WeatherApp
//
//  Created by Frédéric Helfer on 20/02/23.
//

import Foundation

class WeatherDataService: ObservableObject {
    
    private let baseUrl = "https://api.openweathermap.org"
    private let apiKey = "38ec62852779e6ad30a064b9e15e9bff"
    private let units = "metric"
    
    static let shared = WeatherDataService()
    private init() {  }
    
    public func fetchCurrentWeather(location: Location) async throws -> CurrentWeather {
        guard
            let url = URL(string: "\(baseUrl)/data/2.5/weather?lat=\(location.lat)&lon=\(location.lon)&appid=\(apiKey)&units=\(units)&lang=\(location.language)") else {
            throw URLError(.badURL)
        }

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
    
    public func fetchHourlyForecast(location: Location) async throws -> HourlyForecast {
        guard
            let url = URL(string: "\(baseUrl)/data/2.5/forecast?lat=\(location.lat)&lon=\(location.lon)&appid=\(apiKey)&units=\(units)&lang=\(location.language)") else {
            throw URLError(.badURL)
        }

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
    
    public func fetchSearchLocation(location: Location) async throws -> [SearchLocation] {
        guard
//            http://api.openweathermap.org/geo/1.0/direct?q={city name},{state code},{country code}&limit={limit}&appid={API key}
            let url = URL(string: "\(baseUrl)/geo/1.0/direct?q=\(location.cityName)&limit=5&appid=\(apiKey)") else {
            throw URLError(.badURL)
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode([SearchLocation].self, from: data)
            return decoded
        } catch {
            throw URLError(.badServerResponse)
        }
    }
}
