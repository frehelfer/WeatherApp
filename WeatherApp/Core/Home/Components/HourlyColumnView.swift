//
//  HourlyColumnView.swift
//  WeatherApp
//
//  Created by Frédéric Helfer on 21/02/23.
//

import SwiftUI

struct HourlyColumnView: View {
    
    var item: List
    
    var body: some View {
        VStack(spacing: 15) {
            Text(item.dtTxt?.asDateString() ?? "-")
                .font(.headline)
            
            Image(systemName: item.weather.first?.icon?.text ?? "")
                .font(.title2)
            
            Text((item.main?.temp?.asStringRounded() ?? "-") + "°")
                .font(.headline)
                .kerning(1.4)
        }
        .foregroundColor(.theme.accent)
        .frame(minWidth: 70, minHeight: 130)
        .padding(.vertical, 8)
        .background(.thinMaterial.opacity(0.5))
        .cornerRadius(40)
    }
}

struct HourlyColumnView_Previews: PreviewProvider {
    static var previews: some View {
        HourlyColumnView(item: List.example)
            .preferredColorScheme(.dark)
    }
}
