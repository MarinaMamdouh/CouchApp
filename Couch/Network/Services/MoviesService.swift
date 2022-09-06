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
    private var currentPage:Int = 0
    private var totalPages:Int = -1
    private var movieSubscription: AnyCancellable?
    
    init(listType:ListType) {
        self.listType = listType
        getMovies()
    }
    
    func changeListType(_ listType: ListType){
        moviesList = []
        self.listType = listType
        currentPage = 0
        totalPages = -1
        getMovies()
    }
    
    func getMovies(){
        let nextPage = currentPage + 1
        let api = getAPI(page: nextPage)
        let request = api.asRequest()
        
        self.movieSubscription = NetworkManager.performRequest(request)
            .decode(type: MoviesResponse.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] movieResponse in
                self?.moviesList.append(contentsOf: movieResponse.results)
                self?.currentPage = movieResponse.page
                self?.totalPages = movieResponse.totalPages
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


