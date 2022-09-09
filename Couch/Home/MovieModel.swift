//
//  MovieModel.swift
//  Couch
//
//  Created by Marina on 06/09/2022.
//

import Foundation



struct MovieModel: Codable {
    let id: Int
    let originalTitle , title: String
    let posterPath: String

    enum CodingKeys: String, CodingKey {
        case id
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case title
    }
}
