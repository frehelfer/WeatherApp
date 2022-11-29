//
//  PreviewProvider.swift
//  WeatherApp
//
//  Created by Frédéric Helfer on 29/11/22.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
}

class DeveloperPreview {
    
    static let instance = DeveloperPreview()

    private init() {}
    
    var homeVM = HomeViewModel()
    
    let currentWeather = CurrentWeather(
        coord: Coord(lon: -52.4487, lat: -29.737),
        weather: [Weather(id: 802, main: "Clouds", description: "scattered clouds", icon: "03d")],
        base: "stations",
        main: Main(temp: 21.69, feelsLike: 21.77, tempMin: 21.69, tempMax: 21.69, pressure: 1011, humidity: 71, seaLevel: 1011, grndLevel: 1001),
        visibility: 10000,
        wind: Wind(speed: 3.12, deg: 84, gust: 6.23),
        rain: nil,
        clouds: Clouds(all: 28),
        dt: 1669720736,
        sys: Sys(type: nil, id: nil, country: "BR", sunrise: 1669710125, sunset: 1669760071),
        timezone: -10800,
        id: 3450269,
        name: "Santa Cruz do Sul",
        cod: 200)
}
