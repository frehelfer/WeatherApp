//
//  LocationWeatherView.swift
//  WeatherApp
//
//  Created by Frédéric Helfer on 24/02/23.
//

import SwiftUI

struct LocationWeatherView: View {
    @ObservedObject var vm: LocationsViewModel
    var location: SearchLocation
    
    @Environment(\.dismiss) var dismiss
    
    @State var isFav: Bool = false
    
    var body: some View {
        ZStack {
            
            LinearGradient(gradient: Gradient(stops: [
                .init(color: .theme.blueBackground, location: 0.30),
                .init(color: .blue.opacity(0.7), location: 0.80)
            ]), startPoint: .bottomLeading, endPoint: .top)
            .ignoresSafeArea()
            
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Label("Dismiss", systemImage: "xmark")
                            .labelStyle(.iconOnly)
                            .font(.system(size: 20))
                            .foregroundColor(.theme.accent.opacity(0.6))
                            .padding(.horizontal, 20)
                            .padding(.top, 20)
                    }
                    
                    Spacer()
                    
                    Button {
                        isFav.toggle()
                    } label: {
                        Label("Add to favorites", systemImage: isFav ? "heart.fill" : "heart")
                            .labelStyle(.iconOnly)
                            .font(.system(size: 25))
                            .foregroundColor(isFav ? .red : .theme.accent.opacity(0.6))
                            .padding(.horizontal, 20)
                            .padding(.top, 20)
                    }
                    
                }
                
                if vm.isLoading == false {
                    Spacer()

                    if let model = vm.currentWeather {
                        WeatherInfo(currentWeather: model)
                    }

                    Spacer()

                    if let model = vm.forecastWeather {
                        HourlyForecastRow(items: model)
                    }

                    Spacer()
                } else {
                    // TODO: Show loading view, getting location etc...
                    Spacer()
                    ProgressView()
                    Spacer()
                }
                
            }
        }
        .task {
            await vm.fetchData(location: Location(lat: location.lat, lon: location.lon))
        }
    }
}

struct LocationWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        LocationWeatherView(vm: LocationsViewModel(), location: SearchLocation.example)
    }
}
