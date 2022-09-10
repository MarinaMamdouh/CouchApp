//
//  MovieListViewModel.swift
//  Couch
//
//  Created by Marina on 09/09/2022.
//

import Foundation
import Combine

class MoviesListViewModel: ObservableObject{

    @Published var currentDisplayedIndex: Int = 0
    @Published var selectedMovie: MovieModel?
    @Published var showMovieDetails:Bool = false
    @Published var isLoading: Bool = false
    @Published var onScrollEnded: ()->() = {}
    @Published var scrollEnded:Bool = false
    
    var numberOfMovies:Int = 0
    private(set) var pagination: Bool = false
    private var cancellables = Set<AnyCancellable>()
    private var lastMovieIndex: Int{
        return numberOfMovies - 1
    }
    
    init(onSelectedAction: @escaping ()->()){
        self.onScrollEnded = onSelectedAction
        self.pagination = true
        addSubscribers()
    }
    
    init(){
        addSubscribers()
    }
    
    
    private func addSubscribers(){
        $currentDisplayedIndex
            .sink { [weak self] index in
                guard let self = self else {return}
                if index == self.lastMovieIndex{
                    self.scrollEnded = true
                }
            }
            .store(in: &cancellables)
        
        $selectedMovie
            .sink { [weak self] selectedMovie in
                guard let self = self  , let _ = selectedMovie else {return}
                self.showMovieDetails = true
            }
            .store(in: &cancellables)
        
        $scrollEnded
            .sink { [weak self] ended in
                guard let self = self else {return}
                if ended && self.pagination{
                    self.isLoading = true
                    self.onScrollEnded()
                }
            }
            .store(in: &cancellables)
        
    }
}
