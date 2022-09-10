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

struct ColorTheme{
    let background = Color("BackgroundColor")
    let primary = Color("PrimaryColor")
    let secondary = Color("SecondaryColor")
    let accent = Color("AccentColor")
    let red = Color("Red")
    let shadow = Color.black
}
//extension Constants{
//    struct UIColors{
//        static let defaultBackgroundColor = UIColor(red: 26.0/255.0, green: 26.0/255.0, blue: 26.0/255.0, alpha: 1.0)
//    }
//}
