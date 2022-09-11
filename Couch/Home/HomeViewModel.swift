//
//  HomeViewModel.swift
//  Couch
//
//  Created by Marina on 05/09/2022.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject{
    ///////////////Publishers properties////////////////

    @Published var topRatedMovies:[MovieModel] = [] // top Rated Movies Data
    @Published var mostPopularMovies:[MovieModel] = [] // most Popular Movies Data
    // selected List ( top rated, most popular , ... ) index in predefined array of lists types
    @Published var selectedListTypeIndex:Int = 0
    // current displayed list type
    @Published var currentSorting:ListType
    // state that show us if UI needs to load data or not
    @Published var isLoading:Bool = false
    
    @Published var noData:Bool = true
    //////////////Private properties////////////////
    //////////////////////////////////////////////
    
    /// Properties that Handle ListTypes dynamicly
    private(set) var listTypesNames:[String] = [] // strings of lists titles to provide it to UI
    // coressponding array of listType items arranged
    private let listTypes:[ListType] = [.mostPopular, .topRated]
    
    //// Services and Cancellables properties
    private var topRatedMovieService: MoviesService
    private var mostPopularMovieService: MoviesService
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        // set the default list Type to be the first on of our predefined list (.mostPopular)
        currentSorting = listTypes.first ?? .mostPopular
        // initialize the needed Services
        mostPopularMovieService = MoviesService(listType: .mostPopular)
        topRatedMovieService = MoviesService(listType: .topRated)
        // generate the list Types titles that UI will need
        generateListTypesNames()
        // Subscribe to all needed publishers and services changes
        subscribeToServices()
        subscribeToPublishers()
    }
    
    private func generateListTypesNames(){
        for listType in listTypes{
            listTypesNames.append(listType.displayedText)
        }
    }
    
    private func subscribeToServices(){
        // subscribe on Top Rated Movies service retrieved list
        topRatedMovieService.$moviesList
            .sink { [weak self] (recievedMovies) in
                self?.topRatedMovies = recievedMovies
                self?.isLoading = false
                if !recievedMovies.isEmpty{
                    self?.noData = false
                }
            }
            .store(in: &cancellables)
        
        // subscribe on Most Popular Movies service retrieved list
        mostPopularMovieService.$moviesList
            .sink {[weak self] (recievedMovies) in
                self?.mostPopularMovies = recievedMovies
                self?.isLoading = false
                if !recievedMovies.isEmpty{
                    self?.noData = false
                }
            }
            .store(in: &cancellables)
            
    }
    
    private func subscribeToPublishers(){
        // Subscribe on changes in Selected List Type
        $selectedListTypeIndex
            .sink {[weak self] recievedIndex in
                // upadate the current Sorting
                guard let selectedListType = self?.listTypes[recievedIndex] else { return }
                self?.currentSorting = selectedListType
                
            }
            .store(in: &cancellables)
        
        // Subscribe on loading status
        $isLoading
            .sink {[weak self] needsToLoadMoreData in
                if needsToLoadMoreData{
                    // load more movies for the UI
                    self?.getMoreMovies()
                }
            }
            .store(in: &cancellables)
    }
    
    // Load the more movies for the current displayed type of sorting list
    private func getMoreMovies(){
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
