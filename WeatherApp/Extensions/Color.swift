//
//  Color.swift
//  WeatherApp
//
//  Created by Frédéric Helfer on 29/11/22.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

class ColorTheme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let blue = Color("BlueColor")
    let secondaryText = Color("SecondaryTextColor")
}

