//
//  LocationsRowView.swift
//  WeatherApp
//
//  Created by Frédéric Helfer on 23/02/23.
//

import SwiftUI

struct LocationsRowView: View {
    var item: CurrentWeather
    
    var body: some View {
        HStack {
            VStack {
                Text("Location Name")
                Spacer()
                Text(item.weather.first?.description?.capitalized ?? "")
            }
            
            Spacer()
            
            VStack {
                Text((item.main?.temp?.asStringRounded() ?? "-") + "°")
                    .kerning(1.3)
                    .font(.system(size: 30).bold())
                Spacer()
                Text("Lat: Lon:")
            }
        }
        .padding()
        .background(.green)
        .cornerRadius(20)
        .frame(height: 110)
    }
}

//struct LocationsRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        LocationsRowView(item: )
//    }
//}
