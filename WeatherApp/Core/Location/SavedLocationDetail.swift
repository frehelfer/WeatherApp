//
//  SavedLocationDetail.swift
//  WeatherApp
//
//  Created by Frédéric Helfer on 28/02/23.
//

import SwiftUI

struct SavedLocationDetail: View {
    @ObservedObject var vm: LocationsViewModel
    var location: CurrentWeather
    
    @State var isFav: Bool = true
    
    var body: some View {
        ZStack {
            
            LinearGradient(gradient: Gradient(stops: [
                .init(color: .theme.blueBackground, location: 0.30),
                .init(color: .blue.opacity(0.7), location: 0.80)
            ]), startPoint: .bottomLeading, endPoint: .top)
            .ignoresSafeArea()
            
            VStack {
                
                if vm.isLoading == false {
                    Spacer()
                    
                    if let model = vm.currentWeather {
                        WeatherInfo(currentWeather: model)
                    }
                    
                    Spacer()
                    
                    if let model = vm.forecastWeather {
                        HourlyForecastRow(items: model)
                    }
                } else {
                    // TODO: Show loading view, getting location etc...
                    Spacer()
                    ProgressView()
                    Spacer()
                }
                
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isFav.toggle()
                    print(isFav)
                    vm.addOrRemoveLocation(location: Location(
                        weatherID: location.id,
                        cityName: location.name,
                        lat: location.coord.lat,
                        lon: location.coord.lon), isFav: isFav)
                } label: {
                    Label("Add to favorites", systemImage: isFav ? "heart.fill" : "heart")
                        .labelStyle(.iconOnly)
                        .foregroundColor(isFav ? .red : .theme.accent.opacity(0.6))
                }
                
            }
        }
        .onAppear {
            if vm.savedLocations.contains(where: { $0.weatherID == location.id }) {
                isFav = true
            }
        }
        .task {
            await vm.fetchData(location: Location(
                weatherID: location.id,
                lat: location.coord.lat,
                lon: location.coord.lon)
            )
        }
    }
}

struct SavedLocationDetail_Previews: PreviewProvider {
    static var previews: some View {
        SavedLocationDetail(vm: LocationsViewModel(), location: CurrentWeather.example)
    }
}
