//
//  Database.swift
//  Couch
//
//  Created by Marina on 10/09/2022.
//

import Foundation

extension Constants{
    struct Database{
        static let favoriteMovieEntity = "FavoriteMovieEntity"
        static let moviesContainer = "MoviesContainer"
        
        struct FavoriteMovieKeys{
            static let id = "id"
            static let title = "title"
            static let originalTitle = "originalTitle"
            static let posterPath = "posterPath"
        }
    }
}
