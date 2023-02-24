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
                            
                            mainInfo
                            
                            Spacer()
                            
                            if let model = vm.forecastWeather {
                                HourlyForecastRow(items: model)
                            }
                            
                            Spacer()
                        } else {
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

extension HomeView {
    
    var mainInfo: some View {
        VStack(spacing: 10) {
            Text(vm.currentWeather?.name ?? "")
                .font(.title)
                .fontWeight(.medium)
            
            Text((vm.currentWeather?.main.temp?.asStringRounded() ?? "-") + "°C")
                .font(.system(size: 50))
                .fontWeight(.semibold)
            
            Text(vm.currentWeather?.weather.first?.description?.capitalized ?? "")
                .foregroundColor(.theme.secondaryText)
            
            HStack(spacing: 6) {
                Text((vm.currentWeather?.main.tempMin?.asStringRounded() ?? "-") + "° /")
                Text((vm.currentWeather?.main.tempMax?.asStringRounded() ?? "-") + "°")
            }
        }
        .foregroundColor(.theme.accent)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(vm: HomeViewModel())
            .environmentObject(LocationDataManager())
    }
}
