//
//  Animation.swift
//  Couch
//
//  Created by Marina on 08/09/2022.
//

import SwiftUI

extension Animation {
    // to stop forever animation depends on a boolean
    func `repeat`(while expression: Bool, autoreverses: Bool = true) -> Animation {
        if expression {
            return self.repeatForever(autoreverses: autoreverses)
        } else {
            return self
        }
    }
}
