//
//  MovieDetailsViewModel.swift
//  Couch
//
//  Created by Marina on 09/09/2022.
//

import Foundation
import Combine
import UIKit

class MovieDetailsViewModel: ObservableObject{
    
    @Published var detailsModel: MovieDetailsModel?
    @Published var movie: MovieModel?
    @Published var movieBackdrop: UIImage?
    @Published var details: MovieDetails?
    @Published var isFavorite:Bool = false
    @Published var isTapped: Bool = false
    @Published var showFavorite: Bool

    private var movieDetailsService: MovieDetailsService?
    private var downloadImageService: DownloadImageService?
    private let favoritesDataManager = FavoriteDataManager()
    private var cancellables = Set<AnyCancellable>()
    
    // intitialize with ready moviedetails (this is means we have only get the backdrop image)
    // showFavorite: To tell the view to show favorite button or not
    init(movieDetails: MovieDetailsModel, showFavorite: Bool){
        detailsModel = movieDetails
        self.showFavorite = showFavorite
        addSubscribers()
    }
    
    // initialize with movie model (this is means we have to get movie details & backdrop image)
    // showFavorite: To tell the view to show favorite button or not
    init(movie: MovieModel, showFavorite: Bool){
        self.movie = movie
        self.showFavorite = showFavorite
        movieDetailsService = MovieDetailsService(movie: movie)
        favoritesDataManager.getFavoriteMovie(of: movie.id)
        addSubscribers()
    }
    
    private func addSubscribers(){
        
        // listen to moviedetails retrieved by movie details service
        movieDetailsService?.$movieDetails
            .sink { [weak self] details in
                // update our movie details model
                self?.detailsModel = details
            }
            .store(in: &cancellables)
        
        // listen to our movie details model
        $detailsModel
            .sink { [weak self] recievedDetailsModel in
                guard let recievedDetailsModel = recievedDetailsModel else { return }
                // convert Movie Details model to easier Movie details for our View to display
                self?.details =  MovieDetails.convertModel(model: recievedDetailsModel)
                // begin downloading the backdrop image
                guard let path = self?.details?.backdropImage else { return }
                self?.beginDownloadImage(backdropPath: path)
            }
            .store(in: &cancellables)
        
        // listen to favorite data manager if the movie exists in saved user's favorites
        favoritesDataManager.$requestedFavoriteMovie
            .sink { [weak self] entity in
                guard let self = self, let _ = entity else { return }
                // update the view model that the movie is one of user's favorites
                self.isFavorite = true
            }
            .store(in: &cancellables)
        
        // listen to isFavorite flag
        $isFavorite
            .sink { [weak self] putInFavorite in
                guard let self = self , let movie = self.movie
                else {return}
                // convert the movie to coreData FavoriteMovie entity
                let entity = FavoriteMovieEntity.convert(model: movie)
                if putInFavorite{
                    self.favoritesDataManager.save(entity)
                }else{
                    self.favoritesDataManager.delete(entity)
                }
            }
            .store(in: &cancellables)
    }
    
    
    private func beginDownloadImage(backdropPath: String){
        downloadImageService = DownloadImageService(imagePath: backdropPath, imageSize: Constants.APIs.backdropImageSize)
        // listen to download image service's image
        downloadImageService?.$image
            .sink { [weak self] recievedImage in
                // update the movie backdrop image
                self?.movieBackdrop = recievedImage
            }
            .store(in: &cancellables)
    }
    
}
