//
//  SavedLocationsRow.swift
//  WeatherApp
//
//  Created by Frédéric Helfer on 27/02/23.
//

import SwiftUI

struct SavedLocationsRow: View {
    var currentWeather: CurrentWeather
    //    var location: Location
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(currentWeather.name)
                    .font(.title)
                    .fontWeight(.medium)
                
                Spacer()
                
                HStack {
                    Image(systemName: currentWeather.weather.first?.icon?.text ?? "")
                        .font(.title)
                        .foregroundColor(.theme.accent.opacity(0.8))
                    
                    Text(currentWeather.weather.first?.description?.capitalized ?? "")
                        .foregroundColor(.theme.secondaryText)
                }
            }
            
            Spacer()
            
            VStack {
                Text((currentWeather.main.temp?.asStringRounded() ?? "-") + "°C")
                    .font(.system(size: 30))
                    .fontWeight(.semibold)
                
                Spacer()
                
                HStack(spacing: 6) {
                    Text((currentWeather.main.tempMin?.asStringRounded() ?? "-") + "° /")
                    Text((currentWeather.main.tempMax?.asStringRounded() ?? "-") + "°")
                }
            }
        }
        .frame(height: 80)
        .padding()
        .background(Color.theme.blueBackground.opacity(0.8))
        .cornerRadius(20)
    }
}

struct SavedLocationsRow_Previews: PreviewProvider {
    static var previews: some View {
        SavedLocationsRow(currentWeather: CurrentWeather.example)
    }
}
