//
//  HomeViewModel.swift
//  Couch
//
//  Created by Marina on 05/09/2022.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject{
    @Published var topRatedMovies:[MovieModel] = []
    @Published var mostPopularMovies:[MovieModel] = []
    @Published var selectedListTypeIndex:Int = 0
    @Published var currentSorting:ListType
    
    private(set) var listTypesNames:[String] = []
    private let listTypes:[ListType] = [.mostPopular, .topRated]
    
    private var topRatedMovieService: MoviesService
    private var mostPopularMovieService: MoviesService
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        currentSorting = listTypes.first ?? .mostPopular
        mostPopularMovieService = MoviesService(listType: .mostPopular)
        topRatedMovieService = MoviesService(listType: .topRated)
        generateListTypesNames()
        subscribeToServices()
    }
    
    private func generateListTypesNames(){
        for listType in listTypes{
            listTypesNames.append(listType.displayedText)
        }
    }
    
    private func subscribeToServices(){
        topRatedMovieService.$moviesList
            .sink { [weak self] (recievedMovies) in
                self?.topRatedMovies = recievedMovies
            }
            .store(in: &cancellables)
        
        mostPopularMovieService.$moviesList
            .sink {[weak self] (recievedMovies) in
                self?.mostPopularMovies = recievedMovies
            }
            .store(in: &cancellables)
        
        $selectedListTypeIndex
            .sink {[weak self] recievedIndex in
                guard let selectedListType = self?.listTypes[recievedIndex] else { return }
                self?.currentSorting = selectedListType
                
            }
            .store(in: &cancellables)
        
        $currentSorting
            .sink {[weak self] recievedListType in
                self?.getMoreMovies()
            }
            .store(in: &cancellables)
            
            
    }
    
    func getMoreMovies(){
        switch currentSorting {
        case .topRated:
            topRatedMovieService.getMovies()
        case .mostPopular:
            mostPopularMovieService.getMovies()
        }
        
    }

}

enum ListType:CaseIterable{
    case topRated
    case mostPopular
    
    var displayedText:String {
        switch self {
        case .topRated:
            return Constants.Texts.topRatedFilterBarItem
        case .mostPopular:
            return Constants.Texts.mostPopularFilterBarItem
        }
    }
    
}
