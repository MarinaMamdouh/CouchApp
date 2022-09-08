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
    private var listType:ListType
    private var paginationManager: Pagination
    private var movieSubscription: AnyCancellable?
    
    init(listType:ListType) {
        self.listType = listType
        self.paginationManager = PaginationManager()
        getMovies()
    }
    init(listType:ListType, pagination:Pagination){
        self.listType = listType
        self.paginationManager = pagination
        getMovies()
    }
    func getMovies(){
        guard let nextPage = paginationManager.getNextPage() else { return }
        let api = getAPI(page: nextPage)
        let request = api.asRequest()
        
        self.movieSubscription = NetworkManager.performRequest(request)
            .decode(type: MoviesResponse.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] movieResponse in
                self?.moviesList.append(contentsOf: movieResponse.results)
                self?.paginationManager.save(totalPagesInServer: movieResponse.totalPages, lastPageLoaded: movieResponse.page)
                self?.movieSubscription?.cancel()
        })
    }
    
    private func getAPI(page: Int)-> APIRequest{
        switch listType {
        case .topRated:
            return APIRequest.getTopRatedMovies(page)
        case .mostPopular:
            return APIRequest.getMostPopularMovies(page)
        }
    }
}


