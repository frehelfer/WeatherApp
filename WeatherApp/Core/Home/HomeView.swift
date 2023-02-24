//
//  HomeView.swift
//  WeatherApp
//
//  Created by Frédéric Helfer on 20/02/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var locationDataManager: LocationDataManager
    @StateObject var vm = HomeViewModel()
    
    var body: some View {
        ZStack {
            
            LinearGradient(gradient: Gradient(stops: [
                .init(color: .theme.blueBackground, location: 0.30),
                .init(color: .blue.opacity(0.5), location: 0.90)
            ]), startPoint: .bottomLeading, endPoint: .top)
            .ignoresSafeArea()
            
            GeometryReader { proxy in
                ScrollView {
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
                            
                            Spacer()
                        } else {
                            // TODO: Show loading view, getting location etc...
                            ProgressView()
                        }
                    }
                    .frame(minHeight: proxy.size.height)
                    .frame(maxWidth: .infinity)
                }
                .refreshable {
                    locationDataManager.requestLocation()
                }
            }
        }
        .onChange(of: locationDataManager.isLoading, perform: { newValue in
            guard
                newValue == false,
                let location = locationDataManager.location
            else { return }
            
            Task {
                await vm.fetchData(location: location)
            }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(vm: HomeViewModel())
            .environmentObject(LocationDataManager())
    }
}
