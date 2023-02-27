//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Frédéric Helfer on 20/02/23.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    @StateObject var locationDataManager = LocationDataManager()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(locationDataManager)
        }
    }
}
