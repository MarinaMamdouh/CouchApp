//
//  MovieDetails.swift
//  Couch
//
//  Created by Marina on 12/09/2022.
//

import Foundation
// View's representation of Movie Details

struct MovieDetails{
    
    var originalTitle: String = ""
    var backdropImage: String = ""
    var overView: String = ""
    var rating: String = "" // e.g. 6.5
    var releaseYear: String = "" // e.g. (2002)
    var releaseDate: String = ""
    var genres: String = "" // e.g. Action, Drama, Thriller
    var runTime: Int = 0
    
    // Convert MovieDetailsModel to View's MovieDetails
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
