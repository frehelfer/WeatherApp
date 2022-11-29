//
//  CurrentWeatherDataService.swift
//  WeatherApp
//
//  Created by Frédéric Helfer on 26/11/22.
//

import Foundation
import Combine

class WeatherDataService {
    
    @Published var currentWeather: CurrentWeather? = nil
    @Published var hourlyForecast: HourlyForecast? = nil
    private var currentWeatherSubscription: AnyCancellable?
    private var hourlyForecastSubscription: AnyCancellable?
    
    init() {
        
    }
    
    func getWeather(lat: Double, lon: Double) {
        getCurrentWeather(lat: lat, lon: lon)
        getHourlyForecast(lat: lat, lon: lon)
    }
    
    private func getCurrentWeather(lat: Double, lon: Double) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=38ec62852779e6ad30a064b9e15e9bff&units=metric") else { return }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        currentWeatherSubscription = NetworkingManager.download(url: url)
            .decode(type: CurrentWeather.self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedCurrentWeather in
                self?.currentWeather = returnedCurrentWeather
                self?.currentWeatherSubscription?.cancel()
            })
    }
    
    private func getHourlyForecast(lat: Double, lon: Double) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=38ec62852779e6ad30a064b9e15e9bff&units=metric") else { return }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        hourlyForecastSubscription = NetworkingManager.download(url: url)
            .decode(type: HourlyForecast.self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedHourlyForecast in
                self?.hourlyForecast = returnedHourlyForecast
                self?.hourlyForecastSubscription?.cancel()
            })
    }
}
