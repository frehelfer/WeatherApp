//
//  HourlyForecastRow.swift
//  WeatherApp
//
//  Created by Frédéric Helfer on 21/02/23.
//

import SwiftUI

struct HourlyForecastRow: View {
    var items: HourlyForecast
    
    var body: some View {
        VStack {
            Text("3 Hourly Forecast")
                .font(.headline)
                .foregroundColor(.theme.accent)
            
            Divider()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(items.list) { item in
                        GeometryReader { geo in
                            
                            HourlyForecastColumn(item: item)
                                .rotation3DEffect(
                                    Angle(degrees: getAngle(geo: geo) / -4),
                                    axis: (x: 0.4, y: 6, z: 0.7))
                        }
                        .frame(width: 70, height: 165)
                    }
                }
                .padding(.leading)
                .padding(.top, 20)
                .padding(.trailing, 50)
            }
            
        }
        .foregroundColor(.theme.accent)
        .padding(.vertical)
        .background(Color.theme.hourlyBackground)
    }
    
    func getAngle(geo: GeometryProxy) -> Double {
        let currentX = geo.frame(in: .global).minX
        
        if currentX < 240 {
            return 0
        }
        return Double(currentX - 240)
    }
}

struct HourlyForecastRow_Previews: PreviewProvider {
    static var previews: some View {
        HourlyForecastRow(items: HourlyForecast.example)
            .preferredColorScheme(.dark)
    }
}
