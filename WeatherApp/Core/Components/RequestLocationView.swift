//
//  RequestLocationView.swift
//  WeatherApp
//
//  Created by Frédéric Helfer on 22/02/23.
//

import SwiftUI

struct RequestLocationView: View {
    @EnvironmentObject var locationDataManager: LocationDataManager
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.3).ignoresSafeArea()
            
            VStack {
                Image(systemName: "location.circle")
                    .resizable()
                    .frame(width: 100, height: 100, alignment: .center)
                    .foregroundColor(.blue)
                
                Button {
                    locationDataManager.requestPermission()
                } label: {
                    Label("Allow tracking", systemImage: "location")
                }
                .padding(10)
                .foregroundColor(.white)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                Text("We need your permission to show you the weather for your site.")
                    .foregroundColor(.gray)
                    .font(.caption)
                
            }
        }
    }
}

struct RequestLocationView_Previews: PreviewProvider {
    static var previews: some View {
        RequestLocationView()
            .environmentObject(LocationDataManager())
    }
}
