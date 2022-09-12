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
    // Services and cancellables ///
    private let favoritesDataManager = FavoriteDataManager()
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        _ = favoritesDataManager.fetchData()
        addSubscribers()
    }
    
    private func addSubscribers(){
        // listen to favoriteDataManager fetched movie entities
        favoritesDataManager.$favoriteMovies
            .sink { [weak self] fetchedFavMovies in
                self?.updateFavorites(entities: fetchedFavMovies)
            }
            .store(in: &cancellables)
    }
    
    // update favorite movie models list with retrieved entities from core data
    private func updateFavorites(entities: [FavoriteMovieEntity]){
        var fetchedMovies = [MovieModel]()
        // map all entities for movie models
        for entity in entities{
            fetchedMovies.append(entity.mapToMovieModel())
        }
        // update favorite movies list
        self.favMovies = fetchedMovies
    }
}
