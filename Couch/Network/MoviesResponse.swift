//
//  MoviesResponse.swift
//  Couch
//
//  Created by Marina on 06/09/2022.
//

import Foundation

struct MoviesResponse: Codable {
    let page: Int
    let results: [MovieModel]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
