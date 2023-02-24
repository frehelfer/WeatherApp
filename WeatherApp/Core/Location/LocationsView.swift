//
//  LocationsView.swift
//  WeatherApp
//
//  Created by Frédéric Helfer on 23/02/23.
//

import SwiftUI

struct LocationsView: View {
    @State private var vm = LocationsViewModel()
    @State var searchText: String = ""
    
    @State private var showLocationWeather = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.theme.blueBackground.ignoresSafeArea()
                
                VStack {
                    List {
                        ForEach(vm.searchedLocations) { location in
                            Button {
                                showLocationWeather.toggle()
                            } label: {
                                Text("\(location.name), \(location.state ?? ""), \(location.country)")
                            }
                            .sheet(isPresented: $showLocationWeather) {
                                LocationWeatherView()
                            }
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

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LocationsView()
        }
    }
}
