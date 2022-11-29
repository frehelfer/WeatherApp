//
//  MainInfoView.swift
//  WeatherApp
//
//  Created by Frédéric Helfer on 29/11/22.
//

import SwiftUI

struct MainInfoView: View {
    var currentWeather: CurrentWeather
    
    var body: some View {
        ZStack {
            VStack(spacing: 8) {
                Text(currentWeather.name ?? "")
                    .font(.title)
                    .fontWeight(.medium)
                
                Text((currentWeather.main?.temp?.asNumberString() ?? "-") + "°C")
                    .font(.system(size: 50))
                    .fontWeight(/*@START_MENU_TOKEN@*/.semibold/*@END_MENU_TOKEN@*/)
                
                Text(currentWeather.weather?.first?.description?.capitalized ?? "")
                    .foregroundColor(.theme.secondaryText)
                
                HStack(spacing: 6) {
                    Text((currentWeather.main?.tempMin?.asNumberString() ?? "-") + "° /")
                    Text((currentWeather.main?.tempMax?.asNumberString() ?? "-") + "°")
                }
            }
            .foregroundColor(.theme.accent)
        }
    }
}

struct MainInfoView_Previews: PreviewProvider {
    static var previews: some View {
        MainInfoView(currentWeather: dev.currentWeather)
            .preferredColorScheme(.dark)
    }
}
