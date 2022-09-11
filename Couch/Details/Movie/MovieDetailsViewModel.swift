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
    @Published var imageIsLoading:Bool = true
    @Published var isFavorite:Bool = false
    @Published var isTapped: Bool = false
    private var movieDetailsService: MovieDetailsService?
    private let downloadImageService: DownloadImageService
    private let favoritesDataManager = FavoriteDataManager()
    private var cancellables = Set<AnyCancellable>()
    
    init(movieDetails: MovieDetailsModel){
        detailsModel = movieDetails
        downloadImageService = DownloadImageService(imageSize: Constants.APIs.backdropImageSize)
        addSubscribers()
    }
    
    init(movie: MovieModel){
        self.movie = movie
        movieDetailsService = MovieDetailsService(movie: movie)
        downloadImageService = DownloadImageService(imageSize: Constants.APIs.backdropImageSize)
        favoritesDataManager.getFavoriteMovie(of: movie.id)
        addSubscribers()
    }
    
    private func addSubscribers(){
        movieDetailsService?.$movieDetails
            .sink { [weak self] details in
                self?.detailsModel = details
            }
            .store(in: &cancellables)
        
        $detailsModel
            .sink { [weak self] recievedDetailsModel in
                guard let recievedDetailsModel = recievedDetailsModel else { return }
                self?.details =  MovieDetails.convertModel(model: recievedDetailsModel)
                guard let path = self?.details?.backdropImage else { return }
                self?.beginDownloadImage(backdropPath: path)
            }
            .store(in: &cancellables)
        
        favoritesDataManager.$requestedFavoriteMovie
            .sink { [weak self] entity in
                guard let self = self, let _ = entity else { return }
                self.isFavorite = true
            }
            .store(in: &cancellables)
        
        $isFavorite
            .sink { [weak self] putInFavorite in
                guard let self = self , let movie = self.movie
                else {return}
                
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
        downloadImageService.getImage(path: backdropPath)
        downloadImageService.$image
            .sink { [weak self] recievedImage in
                self?.movieBackdrop = recievedImage
                self?.imageIsLoading = false
            }
            .store(in: &cancellables)
    }
    
}

struct MovieDetails{
    
    var originalTitle: String = ""
    var backdropImage: String = ""
    var overView: String = ""
    var rating: String = ""
    var releaseYear: String = ""
    var releaseDate: String = ""
    var genres: String = ""
    var runTime: Int = 0
    
    static func convertModel(model: MovieDetailsModel)-> MovieDetails{
        let rating = String(format: "%.1f", model.voteAverage ?? 0.0)
        var releaseYear = Constants.Texts.unknown
        if let releaseDate = model.releaseDate?.toDate{
            releaseYear = "(\(releaseDate.get(.year)))"
        }
        var genresString = ""
        if let genresArray = model.genres{
            for genre in genresArray{
                genresString += "\(genre.name), "
            }
            genresString.removeLast()
            genresString.removeLast()
        }
        let releaseDateString = model.releaseDate ?? Constants.Texts.unknown
        let runtime = model.runtime ?? 0
        
        return MovieDetails(originalTitle: model.title, backdropImage: model.backdropPath, overView: model.overview, rating: rating, releaseYear: releaseYear, releaseDate: releaseDateString, genres: genresString, runTime: runtime)
    }
}
