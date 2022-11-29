//
//  HomeView.swift
//  WeatherApp
//
//  Created by Frédéric Helfer on 25/11/22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var vm: HomeViewModel
    
    var body: some View {
        ZStack {
            // Background Color
            Color.theme.background.ignoresSafeArea()
            
            // Content Layer
            VStack {
                if let currentWeather = vm.currentWeather {
                    MainInfoView(currentWeather: currentWeather)
                } else {
                    ProgressView()
                }
                
                Spacer()
                
            }
            .padding()
        }
        .onAppear {
            vm.getUserLocation()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HomeView()
        }
        .environmentObject(dev.homeVM)
    }
}
