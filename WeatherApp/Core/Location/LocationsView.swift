//
//  LocationsView.swift
//  WeatherApp
//
//  Created by Frédéric Helfer on 23/02/23.
//

import SwiftUI

struct LocationsView: View {
    @State var searchText: String = ""
    
    var body: some View {
        ZStack {
            VStack {
                List {
                    ForEach(searchResults, id: \.self) { name in
                        NavigationLink {
                            //
                        } label: {
                            LocationsRowView(item: name)
                        }
                    }
                }
            }
        }
        .navigationTitle("Add Places")
        .searchable(text: $searchText, prompt: "Search for a city")
    }
    
//    var searchResults: [String] {
//        if searchText.isEmpty {
//            return names
//        } else {
//            return names.filter { $0.contains(searchText) }
//        }
//    }
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LocationsView()
        }
    }
}
