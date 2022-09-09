//
//  Text.swift
//  Couch
//
//  Created by Marina on 09/09/2022.
//

import Foundation
import SwiftUI

extension View{
    func posterImageSize()-> some View{
        self
            .frame(maxWidth: Constants.ImageSizes.maxPosterSize.width)
            .frame(maxHeight: Constants.ImageSizes.maxPosterSize.height)
            .aspectRatio(Constants.ImageSizes.posterAspectRatio, contentMode: .fill)
    }
    // sets the layout of view to match our app loading style
    // has secondary color background, if has text it will be the primary color
    func loadingStyle()-> some View{
        self
        .foregroundColor(Color.theme.primary)
        .background(Color.theme.secondary)
    }
}