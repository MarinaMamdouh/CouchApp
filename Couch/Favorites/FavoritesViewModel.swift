//
//  FavoritesViewModel.swift
//  Couch
//
//  Created by Marina on 10/09/2022.
//

import Foundation
import Combine

class FavoritesViewModel: ObservableObject{
    @Published var favMovies: [MovieModel] = []
}
