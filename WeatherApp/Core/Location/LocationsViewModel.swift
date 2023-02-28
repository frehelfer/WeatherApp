//
//  LocationsViewModel.swift
//  WeatherApp
//
//  Created by Frédéric Helfer on 23/02/23.
//

import Foundation
import Combine

@MainActor
class LocationsViewModel: ObservableObject {
    @Published var currentWeather: CurrentWeather? = nil
    @Published var forecastWeather: HourlyForecast? = nil
    @Published var isLoading = false
    
    @Published var savedLocations: [Location] = []
    @Published var savedLocationsWeather: [CurrentWeather] = []
    @Published var searchedLocations: [SearchLocation] = []
    
    private var weatherDataService = WeatherDataService()
    private var coreDataManager = CoreDataManager.shared
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        
        coreDataManager.$locationsEntities
            .map { locationsEntities -> [Location] in
                
                let locations: [Location] = locationsEntities.map({ entity in
                    return Location(
                        id: UUID(),
                        cityName: entity.cityName ?? "",
                        lat: entity.lat,
                        lon: entity.lon
                        )
                })
                
                return locations
            }
            .sink { [weak self] locations in
                self?.savedLocations = locations
            }
            .store(in: &cancellables)
        
        
        $savedLocations
            .sink { [weak self] _ in
                Task {
                    await self?.fetchSavedLocations()
                }
            }
            .store(in: &cancellables)
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
    
    func fetchSavedLocations() async {
        
        do {
            savedLocationsWeather = try await weatherDataService.fetchLocationsWeather(locations: savedLocations)
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Core Data
    private func addLocation(location: Location) {
        coreDataManager.addLocation(location: location)
    }
    
    private func removeLocation(location: Location) {
        coreDataManager.removeLocation(location: location)
    }
    
    public func addOrRemoveLocation(searchLocation: SearchLocation, isFav: Bool) {
        let location = Location(id: UUID(), cityName: searchLocation.name, lat: searchLocation.lat, lon: searchLocation.lon)
        
        if isFav {
            addLocation(location: location)
        } else {
            removeLocation(location: location)
        }
    }
}
