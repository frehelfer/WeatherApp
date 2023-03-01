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
        NavigationStack {
            ZStack {
                Color.theme.clearBackground.ignoresSafeArea()
                ScrollView {

                    if searchText.isEmpty {
                        ForEach(vm.savedLocationsWeather) { weather in
                            NavigationLink {
                                SavedLocationDetail(vm: vm, location: weather)
                            } label: {
                                SavedLocationsRow(currentWeather: weather)
                                    .padding(.horizontal)
                            }
                        }
                    } else {
                        searchedLocations
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
        .task {
            await vm.fetchSavedLocations()
        }
        .onAppear {
            
            
        }
    }
}

extension LocationsView {
    
    var searchedLocations: some View {
        VStack(spacing: 1) {
            ForEach(vm.searchedLocations) { location in
                Button {
                    showLocationWeather.toggle()
                } label: {
                    HStack {
                        Text(location.displayFullPlaceName)
                            .foregroundColor(.theme.accent)
                        Spacer()
                    }
                    .padding()
                    .background(.gray.opacity(0.1))
                    .overlay {
                        Rectangle()
                            .stroke(.gray.opacity(0.2), lineWidth: 1)
                    }
                    
                }
                .sheet(isPresented: $showLocationWeather) {
                    LocationWeatherView(vm: vm, location: location)
                }
            }
            
            Spacer()
        }
    }
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        //        NavigationStack {
        LocationsView()
        //        }
    }
}
