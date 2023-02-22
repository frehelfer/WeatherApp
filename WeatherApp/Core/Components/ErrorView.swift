//
//  ErrorView.swift
//  WeatherApp
//
//  Created by Frédéric Helfer on 22/02/23.
//

import SwiftUI

struct ErrorView: View {
    var errorText: String
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.3).ignoresSafeArea()
            
            VStack {
                Image(systemName: "xmark.octagon")
                    .resizable()
                    .frame(width: 100, height: 100, alignment: .center)
                Text(errorText)
                    .multilineTextAlignment(.center)
            }
            .padding(20)
            .foregroundColor(.white)
            .background(Color.red)
            .cornerRadius(10)
            .padding()
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(errorText: "Error!")
    }
}
