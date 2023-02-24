//
//  LocationsView.swift
//  WeatherApp
//
//  Created by Frédéric Helfer on 23/02/23.
//

import SwiftUI

struct LocationsView: View {
    @State var vm = LocationsViewModel()
    @State var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.theme.blueBackground.ignoresSafeArea()
                
                VStack {
                    List {
                        ForEach(vm.searchedLocations) { location in
                            NavigationLink {
                                //
                            } label: {
                                Text("\(location.name), \(location.state ?? ""), \(location.country)")
                            }
                        }
                    }
                }
            }
            .navigationTitle("Add Places")
            .searchable(text: $searchText, prompt: "Search for a city")
            .onChange(of: searchText) { cityName in
                
                Task {
                    await vm.performSearch(text: cityName)
                }
            }
        }
    }
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LocationsView()
        }
    }
}
