//
//  ImageSizes.swift
//  Couch
//
//  Created by Marina on 08/09/2022.
//

import Foundation
import SwiftUI

extension Constants{
    struct ImageSizes{
        static let maxPosterSize = CGSize(width: 185, height: 278) // w185
        static let posterAspectRatio: CGFloat = 2/3
        static let maxBackdropSize = CGSize(width: UIScreen.main.bounds.width, height: 281)
        static let backdropAspectRatio: CGFloat = 16/9
    }
}
