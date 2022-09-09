//
//  MovieListViewModel.swift
//  Couch
//
//  Created by Marina on 09/09/2022.
//

import Foundation

class MovieListViewModel: ObservableObject{
    @Published var showDetails: Bool = false
    @Published var selectedMovie: MovieModel?
    
}
