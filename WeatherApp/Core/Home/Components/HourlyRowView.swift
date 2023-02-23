//
//  HourlyRowView.swift
//  WeatherApp
//
//  Created by Frédéric Helfer on 21/02/23.
//

import SwiftUI

struct HourlyRowView: View {
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
                            HourlyColumnView(item: item)
                                .rotation3DEffect(
                                    Angle(degrees: getPercentage(geo: geo) / -10),
                                    axis: (x: 0.0, y: 10.0, z: 0.0))
                        }
                        .frame(width: 70, height: 165)
                    }
                }
                .padding(.leading)
                .padding(.top, 7)
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

struct HourlyRowView_Previews: PreviewProvider {
    static var previews: some View {
        HourlyRowView(items: HourlyForecast.example)
            .preferredColorScheme(.dark)
    }
}
