//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Frédéric Helfer on 20/10/22.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    @StateObject private var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
                    .environmentObject(vm)
            }
        }
    }
}
