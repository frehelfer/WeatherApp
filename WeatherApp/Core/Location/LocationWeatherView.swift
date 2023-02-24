//
//  LocationWeatherView.swift
//  WeatherApp
//
//  Created by Frédéric Helfer on 24/02/23.
//

import SwiftUI

struct LocationWeatherView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var isFav: Bool = false
    
    var body: some View {
        ZStack {
            Color.blue.ignoresSafeArea()
            
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Label("Dismiss", systemImage: "xmark")
                            .labelStyle(.iconOnly)
                            .font(.system(size: 20))
                            .foregroundColor(.theme.accent.opacity(0.6))
                            .padding(.horizontal, 20)
                            .padding(.top, 20)
                    }

                    Spacer()
                    
                    Button {
                        isFav.toggle()
                    } label: {
                        Label("Add to favorites", systemImage: isFav ? "heart.fill" : "heart")
                            .labelStyle(.iconOnly)
                            .font(.system(size: 25))
                            .foregroundColor(isFav ? .red : .theme.accent.opacity(0.6))
                            .padding(.horizontal, 20)
                            .padding(.top, 20)
                    }

                }
                
                Spacer()
                
                WeatherInfo(currentWeather: CurrentWeather.example)
                    .padding(.bottom, 50)
                
                Spacer()
                
                HourlyForecastRow(items: HourlyForecast.example)
            }
        }
    }
}

struct LocationWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        LocationWeatherView()
    }
}
