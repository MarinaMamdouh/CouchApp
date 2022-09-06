//
//  HomeViewModel.swift
//  Couch
//
//  Created by Marina on 05/09/2022.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject{
    @Published var moviesList:[MovieModel] = []
    var currentSorting:ListType{
        didSet{
            moviesList = []
            movieService = MoviesService(listType: currentSorting)
            subscribeToServices()
        }
    }
    
    private var movieService: MoviesService
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        currentSorting = .mostPopular
        movieService = MoviesService(listType: .mostPopular)
        subscribeToServices()
    }
    
    private func subscribeToServices(){
        movieService.$moviesList
            .sink { [weak self] (recievedMovies) in
                self?.moviesList = recievedMovies
            }
            .store(in: &cancellables)
    }
    
    func getMoreMovies(){
        movieService.getMovies()
    }

}

enum ListType{
    case topRated
    case mostPopular
}
