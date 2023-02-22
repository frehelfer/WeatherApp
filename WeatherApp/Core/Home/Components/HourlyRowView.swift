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
                        HourlyColumnView(item: item)
                    }
                }
                .padding(.leading)
                .padding(.top, 7)
            }
            
        }
        .foregroundColor(.theme.accent)
        .padding(.vertical)
        .background(.thinMaterial.opacity(0.5))
    }
}

struct HourlyRowView_Previews: PreviewProvider {
    static var previews: some View {
        HourlyRowView(items: HourlyForecast.example)
            .preferredColorScheme(.dark)
    }
}
