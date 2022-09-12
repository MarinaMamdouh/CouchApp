//
//  UIColors.swift
//  Couch
//
//  Created by Marina on 05/09/2022.
//

import Foundation
import SwiftUI

extension Color{
    static let theme = ColorTheme()
}

// General Color theme
struct ColorTheme{
    let background = Color("BackgroundColor")
    let primary = Color("PrimaryColor")
    let secondary = Color("SecondaryColor")
    let accent = Color("AccentColor")
    let red = Color("Red")
    let shadow = Color.black
}

