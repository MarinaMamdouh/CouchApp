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
        getMovieDetails()
    }

    func getMovieDetails(){
        let api = APIRequest.getMovieDetails(movie.id)
        let request = api.asRequest()

        self.subscription = NetworkManager.performRequest(request)
            .decode(type: MovieDetailsModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] details in
                self?.movieDetails = details
                self?.subscription?.cancel()
        })
    }

}
