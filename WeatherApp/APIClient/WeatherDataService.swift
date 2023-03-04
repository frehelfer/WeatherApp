//
//  WeatherDataService.swift
//  WeatherApp
//
//  Created by Frédéric Helfer on 20/02/23.
//

import Foundation

@MainActor
class WeatherDataService: ObservableObject {
    
    private let baseUrl = "https://api.openweathermap.org"
    private let apiKey = "38ec62852779e6ad30a064b9e15e9bff"
    private let units = "metric"
    
    init() {  }
    
    public func fetchLocationsWeather(locations: [Location]) async throws -> [CurrentWeather] {
        
        return try await withThrowingTaskGroup(of: CurrentWeather?.self) { group in
            var weathers: [CurrentWeather] = []
            weathers.reserveCapacity(locations.count)
            
            for location in locations {
                group.addTask {
                    try? await self.fetchCurrentWeather(location: location)
                }
            }
            
            for try await weather in group {
                if let weather {
                    weathers.append(weather)
                }
            }
            
            let sortedWeather = weathers.sorted { $0.name < $1.name }
            
            return sortedWeather
        }
        
    }
    
    public func fetchCurrentWeather(location: Location) async throws -> CurrentWeather {
        guard
            let url = URL(string: "\(baseUrl)/data/2.5/weather?lat=\(location.lat)&lon=\(location.lon)&appid=\(apiKey)&units=\(units)&lang=\(location.language)") else {
            throw URLError(.badURL)
        }
        
        print(url)

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let currentWeather = try decoder.decode(CurrentWeather.self, from: data)
            return currentWeather
        } catch {
            throw error
        }
    }
    
    public func fetchHourlyForecast(location: Location) async throws -> HourlyForecast {
        guard
            let url = URL(string: "\(baseUrl)/data/2.5/forecast?lat=\(location.lat)&lon=\(location.lon)&appid=\(apiKey)&units=\(units)&lang=\(location.language)") else {
            throw URLError(.badURL)
        }
        
        print(url)

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
            throw error
        }
    }
    
    public func fetchSearchLocations(location: Location) async throws -> [SearchLocation] {
        guard
//            http://api.openweathermap.org/geo/1.0/direct?q={city name},{state code},{country code}&limit={limit}&appid={API key}
            let url = URL(string: "\(baseUrl)/geo/1.0/direct?q=\(location.cityName)&limit=5&appid=\(apiKey)") else {
            throw URLError(.badURL)
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode([SearchLocation].self, from: data)
            print("fetched..")
            return decoded
        } catch {
            throw error
        }
    }
}
