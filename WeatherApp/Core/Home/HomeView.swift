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
            
            
            Group {
                switch locationDataManager.authorizationStatus {
                case .authorizedAlways, .authorizedWhenInUse:
                    homeView
                    
                case .notDetermined:
                    RequestLocationView()
                    
                case .restricted:
                    ErrorView(errorText: "Location use is restricted.")
                    
                case .denied:
                    ErrorView(errorText: "The app does not have location permissions. Please enable them in settings to start seeing the weather at your location or utilize the manual option bellow.")
                    
                default:
                    Text("Unexpected status")
                }
            }
        }.onAppear {
            locationDataManager.requestLocation()
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

extension HomeView {
    
    var homeView: some View {
        ZStack {
            GeometryReader { proxy in
                ScrollView(.vertical, showsIndicators: false) {
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
                            
                            Text("Getting the weather of your location")
                            ProgressView()
                            
                        }
                    }
                    .frame(minHeight: proxy.size.height)
                    .frame(maxWidth: .infinity)
                }
                .refreshable {
                    locationDataManager.requestLocation()
                    withAnimation {
                        vm.isLoading = true
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(vm: HomeViewModel())
            .environmentObject(LocationDataManager())
    }
}
