//
//  HourlyForecastColumn.swift
//  WeatherApp
//
//  Created by Frédéric Helfer on 21/02/23.
//

import SwiftUI

struct HourlyForecastColumn: View {
    
    var item: HourlyWeather
    
    var body: some View {
        VStack(spacing: 14) {
            VStack(spacing: 2) {
                Text(item.dtTxt?.asTimeAbrev() ?? "-")
                    .font(.headline)
                
                Text(item.dtTxt?.asDaysOfWeek() ?? "-")
                    .font(.caption)
                    .foregroundColor(.theme.secondaryText)
            }
            
            Image(systemName: item.weather.first?.icon?.text ?? "")
                .font(.title2)
                .foregroundColor(.theme.accent.opacity(0.8))
            
            Text((item.main?.temp?.asStringRounded() ?? "-") + "°")
                .font(.headline)
                .kerning(1.4)
        }
        .foregroundColor(.theme.accent)
        .frame(minWidth: 70, minHeight: 145)
        .padding(.vertical, 8)
        .background(.ultraThinMaterial.opacity(0.5))
        .cornerRadius(40)
    }
}

struct HourlyForecastColumn_Previews: PreviewProvider {
    static var previews: some View {
        HourlyForecastColumn(item: HourlyWeather.example)
            .preferredColorScheme(.dark)
    }
}
