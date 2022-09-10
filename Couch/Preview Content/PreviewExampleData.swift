//
//  PreviewExampleData.swift
//  Couch
//
//  Created by Marina on 09/09/2022.
//

import Foundation

// Static Data for preview and tests only
struct PreviewData{
    
    static let movieModelExample = MovieModel(id: 616037, originalTitle: "MyMovie", title: "My Movie: The part Two", posterPath: "/r7XifzvtezNt31ypvsmb6Oqxw49.jpg")
    
    static let moviesListExample = (1...10).map { i in
        MovieModel(id: i, originalTitle: "Movie \(i)", title: "Movie \(i)", posterPath: "/v28T5F1IygM8vXWZIycfNEm3xcL.jpg")
    }
    
    static let movieDetailsExample = MovieDetailsModel(backdropPath: "", id: 616037, releaseDate: "2022-07-06", voteAverage: 6.7, genres: genres, title: "Thor: Love and Thunder", originalTitle: "Thor: Love and Thunder", overview: "After his retirement is interrupted by Gorr the God Butcher, a galactic killer who seeks the extinction of the gods, Thor Odinson enlists the help of King Valkyrie, Korg, and ex-girlfriend Jane Foster, who now inexplicably wields Mjolnir as the Relatively Mighty Girl Thor. Together they embark upon a harrowing cosmic adventure to uncover the mystery of the God Butcher’s vengeance and stop him before it’s too late.", runtime: 119)
    
    static let genres = [
        Genre(id: 1, name: "Action"),
        Genre(id: 2, name: "Fiction"),
        Genre(id: 3, name: "Comedy")
    ]
    

}
