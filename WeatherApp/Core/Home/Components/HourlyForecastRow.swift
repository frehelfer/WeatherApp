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
                                    Angle(degrees: getPercentage(geo: geo) / -10),
                                    axis: (x: 0.0, y: 10.0, z: 0.0))
                        }
                        .frame(width: 70, height: 165)
                    }
                }
                .padding(.leading)
                .padding(.top, 20)
            }
            
        }
        .foregroundColor(.theme.accent)
        .padding(.vertical)
        .background(.ultraThinMaterial)
    }
    
    func getPercentage(geo: GeometryProxy) -> Double {
//        let maxDistance = UIScreen.main.bounds.width / 2
        let currentX = geo.frame(in: .global).minX
        return Double(currentX - 30)
    }
}

struct HourlyForecastRow_Previews: PreviewProvider {
    static var previews: some View {
        HourlyForecastRow(items: HourlyForecast.example)
            .preferredColorScheme(.dark)
    }
}
