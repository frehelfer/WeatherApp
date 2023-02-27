//
//  Color+.swift
//  WeatherApp
//
//  Created by Frédéric Helfer on 21/02/23.
//

import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

class ColorTheme {
    let accent = Color(.label)
    let secondaryText = Color(.secondaryLabel)
    let blueBackground = Color("BlueBackgroundColor")
    let hourlyBackground = Color("HourlyBackgroundColor")
    
    let tabView = UIColor(named: "TabViewColor")
}
