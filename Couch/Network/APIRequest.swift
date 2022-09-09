//
//  APIRequest.swift
//  Couch
//
//  Created by Marina on 06/09/2022.
//

import Foundation

enum APIRequest {
    case getMostPopularMovies(_ page: Int)
    case getTopRatedMovies(_ page: Int)
    case getMovieDetails(_ id: Int)
    case getImage(_ path: String, _ size: String)
    
    private var url: URL? {
        switch self {
        case .getMostPopularMovies(_):
            return URL(string: Constants.APIs.mostPopularMoviesEndPoint)
        case .getTopRatedMovies(_):
            return URL(string: Constants.APIs.topRatedMoviesEndPoint)
        case .getImage(let path, let size):
            var urlString = Constants.APIs.downloadImageEndPoint
            urlString += "/\(size)"
            urlString += "/\(path)"
            return URL(string: urlString)
        case .getMovieDetails(let id):
            var urlString = Constants.APIs.baseMoviesEndPoint
            urlString += "/\(id)"
            return URL(string: urlString)
        }
    }
    
    
    private var parameters: [URLQueryItem] {
        var predifinedParams = [
            Constants.APIs.apiKeyParameter,
            Constants.APIs.moviesLanguageParameter
        ]
        
        switch self {
            
        case .getMostPopularMovies(let page), .getTopRatedMovies(let page):
            predifinedParams.append(Constants.APIs.moviesRegionParameter)
            predifinedParams.append(
                URLQueryItem(name: Constants.APIs.pageParameterKey, value: String(page))
            )
            return predifinedParams
        case .getImage(_,_):
            return []
        case .getMovieDetails(_):
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
