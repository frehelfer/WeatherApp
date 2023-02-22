//
//  ContentView.swift
//  WeatherApp
//
//  Created by Frédéric Helfer on 22/02/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locationDataManager = LocationDataManager()
    
    var body: some View {
        ZStack {
            
            
            NavigationStack {
                TabView {
                    Group {
                        switch locationDataManager.authorizationStatus {
                        case .notDetermined:
                            RequestLocationView()
                                
                        case .restricted:
                            ErrorView(errorText: "Location use is restricted.")
                            
                        case .denied:
                            ErrorView(errorText: "The app does not have location permissions. Please enable them in settings to start seeing the weather at your location or utilize the manual option bellow.")
                            
                        case .authorizedAlways, .authorizedWhenInUse:
                            HomeView()
                                
                        default:
                            Text("Unexpected status")
                        }
                    }
                    .tabItem {
                        Label("Home", systemImage: "thermometer.sun.fill")
                    }
                    
//                    LocationsView()
//                        .tabItem {
//                            Label("Locations", systemImage: "list.star")
//                        }
//
//                    SettingsView()
//                        .tabItem {
//                            Label("Settings", systemImage: "gearshape")
//                        }

                }
            }
            .onAppear {
                locationDataManager.requestPermission()
            }
            .environmentObject(locationDataManager)
        }
    }
}
