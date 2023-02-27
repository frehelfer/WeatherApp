//
//  LocationsViewModel.swift
//  WeatherApp
//
//  Created by Frédéric Helfer on 23/02/23.
//

import Foundation

@MainActor
class LocationsViewModel: ObservableObject {
    @Published var currentWeather: CurrentWeather? = nil
    @Published var forecastWeather: HourlyForecast? = nil
    @Published var isLoading = false
    
    @Published var locationsSaved: [Location] = []
    @Published var searchedLocations: [SearchLocation] = []
    
    private var weatherDataService = WeatherDataService()
    
    init() {
        
    }
    
    func performSearch(text: String) async {
        guard
            !text.isEmpty,
            text.count > 3
        else { return }
        
        let location = Location(cityName: text.replacingOccurrences(of: " ", with: "-").lowercased().folding(options: .diacriticInsensitive, locale: Locale.current))
        
        do {
            searchedLocations = try await weatherDataService.fetchSearchLocations(location: location)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchData(location: Location) async {
        isLoading = true
        
        do {
            let (currentWeather, forecastWeather) = try await (
                weatherDataService.fetchCurrentWeather(location: location),
                weatherDataService.fetchHourlyForecast(location: location)
            )
            self.currentWeather = currentWeather
            self.forecastWeather = forecastWeather
            
        } catch {
            print(error.localizedDescription)
        }
        
        isLoading = false
    }
    
    
}
