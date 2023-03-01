//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by Frédéric Helfer on 21/02/23.
//

import Foundation
import SwiftUI

//Location(lat: -29.737030, lon: -52.448650)

@MainActor
class HomeViewModel: ObservableObject {
    @Published var currentWeather: CurrentWeather? = nil
    @Published var forecastWeather: HourlyForecast? = nil
    @Published var isLoading = true
    
    private var weatherService = WeatherDataService()
    
    init() {
        
    }
    
    func fetchData(location: Location) async {
        isLoading = true
        
        do {
            let (currentWeather, forecastWeather) = try await (
                weatherService.fetchCurrentWeather(location: location),
                weatherService.fetchHourlyForecast(location: location)
            )
            self.currentWeather = currentWeather
            self.forecastWeather = forecastWeather
            withAnimation {
                isLoading = false
            }
        } catch {
            isLoading = false
            print(error.localizedDescription)
        }
    }
}
