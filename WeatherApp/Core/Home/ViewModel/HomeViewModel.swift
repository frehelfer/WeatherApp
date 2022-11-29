//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by Frédéric Helfer on 25/11/22.
//

import Foundation
import Combine
import CoreLocation

class HomeViewModel: ObservableObject {
    
    @Published var currentWeather: CurrentWeather?
    @Published var hourlyForecast: HourlyForecast?
    
    private let locationManager = LocationManager.instance
    
    private let weatherService = WeatherDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        
        weatherService.$currentWeather
            .combineLatest(weatherService.$hourlyForecast)
            .sink { [weak self] (rCurrentWeather, rHourlyForecast)  in
                self?.currentWeather = rCurrentWeather
                self?.hourlyForecast = rHourlyForecast
            }
            .store(in: &cancellables)
    }

    func getUserLocation() {
        guard let location = locationManager.location else { return }
        
        weatherService.getWeather(lat: Double(location.latitude), lon: Double(location.longitude))
    }
}
