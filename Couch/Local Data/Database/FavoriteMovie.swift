//
//  FavoriteMovie.swift
//  Couch
//
//  Created by Marina on 10/09/2022.
//

import Foundation

extension FavoriteMovieEntity{
    func mapToMovieModel() -> MovieModel{
        return MovieModel(id: Int(self.id), originalTitle: self.originalTitle ?? "", title: self.title ?? "", posterPath: self.posterPath ?? "")
    }
    
    static func convert(model: MovieModel)-> FavoriteMovieEntity{
        let context = FavoriteDataManager.container
        let entity = FavoriteMovieEntity(context: context.viewContext)
        entity.setValue(model.title, forKey: Constants.Database.FavoriteMovieKeys.title)
        entity.id = Int64(model.id)
        entity.title = model.title
        entity.originalTitle = model.originalTitle
        entity.posterPath = model.posterPath
        return entity
    }
}
