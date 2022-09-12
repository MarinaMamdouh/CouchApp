//
//  MoviesService.swift
//  Couch
//
//  Created by Marina on 06/09/2022.
//

import Foundation
import Combine

// Service to retrive any kind of Movies List (topRated, mostPopular , .....)
//
class MoviesService{
    @Published var moviesList:[MovieModel] = []
    @Published var endOfMovies:Bool = false
    private var listType:ListType
    private var paginationManager: Pagination
    private var movieSubscription: AnyCancellable?
    
    // initialize with listType (toprated , most popular)
    init(listType:ListType) {
        self.listType = listType
        self.paginationManager = PaginationManager()
        getMovies()
    }
    
    // initialize with the pagination handler (any type of pagination)
    init(listType:ListType, pagination:Pagination){
        self.listType = listType
        self.paginationManager = pagination
        // get first patch of movies on initialization
        getMovies()
    }
    
    func getMovies(){
        // get next page if possible from paginationManager
        guard let nextPage = paginationManager.getNextPage() else {
            // no more pages we retrieved all pages from server
            endOfMovies = true
            return
        }
        // get api request with nextpage parameter
        let api = getAPI(page: nextPage)
        let request = api.asRequest()
        
        // listen to the request's response and decode it to movie model
        self.movieSubscription = NetworkManager.performRequest(request)
            .decode(type: MoviesResponse.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] movieResponse in
                // append the retrievedMovies to the current moviesList
                self?.moviesList.append(contentsOf: movieResponse.results)
                // update the paginationManager with the loadedpage and total pages on the server
                self?.paginationManager.save(totalPagesInServer: movieResponse.totalPages, lastPageLoaded: movieResponse.page)
                // cancel subscription to be released on dinitialization
                self?.movieSubscription?.cancel()
        })
    }
    // get the coressponding API to the List Type
    private func getAPI(page: Int)-> APIRequest{
        switch listType {
        case .topRated:
            return APIRequest.getTopRatedMovies(page)
        case .mostPopular:
            return APIRequest.getMostPopularMovies(page)
        }
    }
}


