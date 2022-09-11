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
    @Published var isShown: Bool = false
    
    private let favoritesDataManager = FavoriteDataManager()
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        _ = favoritesDataManager.fetchData()
        addSubscribers()
    }
    
    private func addSubscribers(){
        $isShown
            .sink {[weak self] favIsShown in
                if favIsShown {
                    _ = self?.favoritesDataManager.fetchData()
                }
            }
            .store(in: &cancellables)
        
        favoritesDataManager.$favoriteMovies
            .sink { [weak self] fetchedFavMovies in
                var fetchedMovies = [MovieModel]()
                for movie in fetchedFavMovies{
                    fetchedMovies.append(movie.mapToMovieModel())
                }
                self?.favMovies = fetchedMovies
            }
            .store(in: &cancellables)
        
    }
}
