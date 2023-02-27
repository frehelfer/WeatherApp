//
//  MainView.swift
//  WeatherApp
//
//  Created by Frédéric Helfer on 22/02/23.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var locationDataManager: LocationDataManager
    
    init() {
        UITabBar.appearance().backgroundColor = Color.theme.tabView
    }
    
    var body: some View {
        TabView {
            Group {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "thermometer.sun.fill")
                    }
                
                LocationsView()
                    .tabItem {
                        Label("Locations", systemImage: "list.star")
                    }
                
                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gearshape")
                    }
            }
            .onAppear {
                locationDataManager.requestPermission()
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(LocationDataManager())
    }
}
