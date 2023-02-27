//
//  LocationsView.swift
//  WeatherApp
//
//  Created by Frédéric Helfer on 23/02/23.
//

import SwiftUI

struct LocationsView: View {
    @StateObject private var vm = LocationsViewModel()
    @State var searchText: String = ""
    
    @State private var showLocationWeather = false
    
    var body: some View {
        ZStack {
            Color.red
            
            NavigationStack {
                
                VStack {
                    List {
                        ForEach(vm.searchedLocations) { location in
                            Button {
                                showLocationWeather.toggle()
                            } label: {
                                Text(location.displayFullPlaceName)
                            }
                            .sheet(isPresented: $showLocationWeather) {
                                LocationWeatherView(vm: vm, location: location)
                            }
                        }
                    }
                }
                .navigationTitle("Add Places")
                .searchable(text: $searchText, prompt: "Search for a city")
                .onChange(of: searchText) { cityName in
                    
                    Task {
                        await vm.performSearch(text: cityName)
                    }
                }
            }
        }
    }
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LocationsView()
        }
    }
}
