//
//  SearchLocation.swift
//  WeatherApp
//
//  Created by Frédéric Helfer on 23/02/23.
//

import Foundation

struct SearchLocation: Codable, Identifiable {
    let id = UUID()
    let name: String
    let lat: Double
    let lon: Double
    let country: String
    let state: String?
    
    static let example = SearchLocation(name: "Porto Alegre", lat: -30.100916650000002, lon: -51.18878818689657, country: "BR", state: "Rio Grande do Sul")
}


