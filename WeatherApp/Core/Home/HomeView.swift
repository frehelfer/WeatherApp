//
//  HomeView.swift
//  WeatherApp
//
//  Created by Frédéric Helfer on 20/02/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject var vm = HomeViewModel()
    
    var body: some View {
        ZStack {
            
            LinearGradient(colors: [Color.blue, Color.white], startPoint: .bottom, endPoint: .top)
                .ignoresSafeArea()
            
            VStack {
                mainInfo
            }
        }
        .task {
            await vm.fetchData()
        }
    }
}

extension HomeView {
    
    var mainInfo: some View {
        VStack(spacing: 10) {
            Text(vm.currentWeather?.name ?? "")
                .font(.title)
                .fontWeight(.medium)
            
            Text((vm.currentWeather?.main?.temp?.asStringRounded() ?? "-") + "°C")
                .font(.system(size: 50))
                .fontWeight(.semibold)
            
            Text(vm.currentWeather?.weather?.first?.description.capitalized ?? "")
                .foregroundColor(.theme.secondaryText)
            
            HStack(spacing: 6) {
                Text((vm.currentWeather?.main?.tempMin?.asStringRounded() ?? "-") + "° /")
                Text((vm.currentWeather?.main?.tempMax?.asStringRounded() ?? "-") + "°")
            }
        }
        .foregroundColor(.theme.accent)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(vm: HomeViewModel())
    }
}
