//
//  MovieDetailsModel.swift
//  Couch
//
//  Created by Marina on 09/09/2022.
//

import Foundation

struct MovieDetailsModel: Codable{
    let backdropPath: String
    let id: Int
    let releaseDate: String?
    let voteAverage: Double?
    let genres: [Genre]?
    let title, originalTitle, overview: String
    let runtime: Int?
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case genres, id
        case originalTitle = "original_title"
        case overview
        case releaseDate = "release_date"
        case runtime, title
        case voteAverage = "vote_average"
    }
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}
