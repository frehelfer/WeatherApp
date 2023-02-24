//
//  LocationsViewModel.swift
//  WeatherApp
//
//  Created by Frédéric Helfer on 23/02/23.
//

import Foundation

class LocationsViewModel: ObservableObject {
    
    @Published var locationsSaved: [Location] = []
    @Published var searchedLocations: [SearchLocation] = []
    
    private var weatherDataService = WeatherDataService.shared
    
    init() {
        
    }
    
    func performSearch(text: String) async {
        guard
            !text.isEmpty,
            text.count > 3
        else { return }
        
        let location = Location(cityName: text.replacingOccurrences(of: " ", with: "-").lowercased())
        
        do {
            searchedLocations = try await weatherDataService.fetchSearchLocations(location: location)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
}
