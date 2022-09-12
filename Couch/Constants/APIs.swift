//
//  APIs.swift
//  Couch
//
//  Created by Marina on 06/09/2022.
//

import Foundation

extension Constants{
    struct APIs{
        static let apiKeyParameter = URLQueryItem(name: "api_key", value: "57ee69215969ddcd3cf245e6b151ec9b")
        
        // In Publish or sharing:
        //static let apiKeyParameter = URLQueryItem(name: "api_key", value: "{{_PUT_API_KEY HERE_}}")
        
        static let baseMoviesEndPoint = "https://api.themoviedb.org/3/movie"
        
        static let topRatedMoviesEndPoint = "https://api.themoviedb.org/3/movie/top_rated"
        
        static let mostPopularMoviesEndPoint = "https://api.themoviedb.org/3/movie/popular"
        
        static let downloadImageEndPoint = "https://image.tmdb.org/t/p"
        
        static let moviesRegionParameter = URLQueryItem(name: "region", value: "US")
        
        static let moviesLanguageParameter = URLQueryItem(name: "language", value: "en-US")
        
        static let pageParameterKey = "page"
        
        static let posterImageSize = "w185"
        static let backdropImageSize = "w780" //w500 is poor resolution
    }
}
