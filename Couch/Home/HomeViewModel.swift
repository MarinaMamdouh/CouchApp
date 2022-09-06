//
//  HomeViewModel.swift
//  Couch
//
//  Created by Marina on 05/09/2022.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject{
    @Published var topRatedMovies:[MovieModel] = []
    @Published var mostPopularMovies:[MovieModel] = []
    
    @Published var currentSorting:ListType
    private var topRatedMovieService: MoviesService
    private var mostPopularMovieService: MoviesService
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        currentSorting = .mostPopular
        mostPopularMovieService = MoviesService(listType: .mostPopular)
        topRatedMovieService = MoviesService(listType: .topRated)
        subscribeToServices()
    }
    
    private func subscribeToServices(){
        topRatedMovieService.$moviesList
            .sink { [weak self] (recievedMovies) in
                self?.topRatedMovies = recievedMovies
            }
            .store(in: &cancellables)
        
        mostPopularMovieService.$moviesList
            .sink {[weak self] (recievedMovies) in
                self?.mostPopularMovies = recievedMovies
            }
            .store(in: &cancellables)
    }
    
    func getMoreMovies(){
        switch currentSorting {
        case .topRated:
            topRatedMovieService.getMovies()
        case .mostPopular:
            mostPopularMovieService.getMovies()
        }
        
    }

}

enum ListType{
    case topRated
    case mostPopular
}
