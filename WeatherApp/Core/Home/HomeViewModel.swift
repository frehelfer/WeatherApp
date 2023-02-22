//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by Frédéric Helfer on 21/02/23.
//

import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    @Published var currentWeather: CurrentWeather? = nil
    @Published var forecastWeather: HourlyForecast? = nil
    
    private var weatherService = WeatherDataService()
    
    init() {
        
    }
    
    func fetchData() async {
        do {
            let (currentWeather, forecastWeather) = try await (
                weatherService.fetchCurrentWeather(location: Location(lat: -29.737030, lon: -52.448650)),
                weatherService.fetchForecastWeather(location: Location(lat: -29.737030, lon: -52.448650))
            )
            self.currentWeather = currentWeather
            self.forecastWeather = forecastWeather
            
        } catch {
            print(error.localizedDescription)
        }
    }
}
