//
//  PreviewExampleData.swift
//  Couch
//
//  Created by Marina on 09/09/2022.
//

import Foundation

// Static Data for preview and tests only
struct PreviewData{
    
    static let movieModelExample = MovieModel(id: 1, originalTitle: "MyMovie", title: "My Movie: The part Two", posterPath: "/r7XifzvtezNt31ypvsmb6Oqxw49.jpg")
    
    static let moviesListExample = (1...10).map { i in
        MovieModel(id: i, originalTitle: "Movie \(i)", title: "Movie \(i)", posterPath: "/v28T5F1IygM8vXWZIycfNEm3xcL.jpg")
    }

}
