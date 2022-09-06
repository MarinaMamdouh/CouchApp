//
//  APIRequest.swift
//  Couch
//
//  Created by Marina on 06/09/2022.
//

import Foundation

enum APIRequest {
    case getMostPopularMovies(Int)
    case getTopRatedMovies(Int)

    private var url: URL? {
        switch self {
        case .getMostPopularMovies(_):
            return URL(string: Constants.APIs.mostPopularMoviesEndPoint)
        case .getTopRatedMovies(_):
            return URL(string: Constants.APIs.topRatedMoviesEndPoint)
        }
    }

    
    private var parameters: [URLQueryItem] {
        var predifinedParams = [
            Constants.APIs.apiKeyParameter,
            Constants.APIs.moviesLanguageParameter,
            Constants.APIs.moviesRegionParameter
        ]
        switch self {
            
        case .getMostPopularMovies(let page), .getTopRatedMovies(let page):
            predifinedParams.append(
                URLQueryItem(name: Constants.APIs.pageParameterKey, value: String(page))
                )
            return predifinedParams
        }
    }

    func asRequest() -> URLRequest {
        guard let url = url else {
            preconditionFailure("Missing URL for route: \(self)")
        }
        if !parameters.isEmpty{
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            components?.queryItems = parameters

            guard let parametrizedURL = components?.url else {
                preconditionFailure("Missing URL with parameters for url: \(url)")
            }
            return URLRequest(url: parametrizedURL)
        }
        
        return URLRequest(url: url)
        
    }
}
