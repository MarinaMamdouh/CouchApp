//
//  MovieDetailsService.swift
//  Couch
//
//  Created by Marina on 09/09/2022.
//

import Foundation
import Combine

class MovieDetailsService{
    @Published var movieDetails: MovieDetailsModel?
    private var movie:MovieModel
    private var subscription: AnyCancellable?
    
    init(movie:MovieModel) {
        self.movie = movie
        // get movie Details upon initialization
        getMovieDetails()
    }

    private func getMovieDetails(){
        // get api request with movie id parameter
        let api = APIRequest.getMovieDetails(movie.id)
        let request = api.asRequest()
        
        // listen to the request's response and decode it to movie details model
        self.subscription = NetworkManager.performRequest(request)
            .decode(type: MovieDetailsModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] details in
                // update movieDetails
                self?.movieDetails = details
                // cancel subscription to be released on dinitialization
                self?.subscription?.cancel()
        })
    }

}
