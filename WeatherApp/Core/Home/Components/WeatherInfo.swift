//
//  WeatherInfo.swift
//  WeatherApp
//
//  Created by Frédéric Helfer on 24/02/23.
//

import SwiftUI

struct WeatherInfo: View {
    var currentWeather: CurrentWeather
    
    var body: some View {
        VStack(spacing: 10) {
            Text(currentWeather.name)
                .font(.title)
                .fontWeight(.medium)
            
            HStack(spacing: 15) {
                Image(systemName: currentWeather.weather.first?.icon?.text ?? "")
                    .font(.title)
                    .foregroundColor(.theme.accent.opacity(0.65))
                
                Text((currentWeather.main.temp?.asStringRounded() ?? "-") + "°C")
                    .font(.system(size: 50))
                    .fontWeight(.semibold)
            }
            
            Text(currentWeather.weather.first?.description?.capitalized ?? "")
                .foregroundColor(.theme.secondaryText)
            
            HStack(spacing: 6) {
                Text((currentWeather.main.tempMin?.asStringRounded() ?? "-") + "° /")
                Text((currentWeather.main.tempMax?.asStringRounded() ?? "-") + "°")
            }
        }
        .foregroundColor(.theme.accent)
    }
}

struct WeatherInfo_Previews: PreviewProvider {
    static var previews: some View {
        WeatherInfo(currentWeather: CurrentWeather.example)
    }
}
