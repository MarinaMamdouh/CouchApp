//
//  HomeViewModel.swift
//  Couch
//
//  Created by Marina on 05/09/2022.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject{

    @Published var topRatedMovies:[MovieModel] = [] // top Rated Movies Data
    @Published var mostPopularMovies:[MovieModel] = [] // most Popular Movies Data
    // selected List ( top rated, most popular , ... ) index in predefined array of lists types
    @Published var selectedListTypeIndex:Int = 0
    // current displayed list type
    @Published var currentSorting:ListType
    // state that show us if UI needs to load data or not
    @Published var isLoading: Bool = false
    
    @Published var noTopRatedData: Bool = true
    @Published var noMostPopularData: Bool = true
    
    /// Properties that Handle ListTypes dynamicly
    private(set) var listTypesNames:[String] = [] // strings of lists titles to provide it to UI
    
    // coressponding array of listType items arranged (for future use we can add more types of lists e.g. comming soon , New , specific genre list)
    private(set) var listTypes:[ListType] = [.mostPopular, .topRated]
    
    //// Services and Cancellables properties
    private var topRatedMovieService: MoviesService
    private var mostPopularMovieService: MoviesService
    private var cancellables = Set<AnyCancellable>()
    
    init(){
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
    
    init(listTypes: [ListType]){
        // set the default list Type to be the first on of our predefined list (.mostPopular)
        self.listTypes = listTypes
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
    
    // generate list types names for View to display ("Most Popular", "Top Rated")
    private func generateListTypesNames(){
        for listType in listTypes{
            listTypesNames.append(listType.displayedText)
        }
    }
    
    private func subscribeToServices(){
        // subscribe on Top Rated Movies service retrieved list
        topRatedMovieService.$moviesList
            .sink { [weak self] (recievedMovies) in
                guard let self = self else {return}
                // update topRated movies list
                self.topRatedMovies = recievedMovies
                // update Loading status
                self.isLoading = false
                // check if top Rated Movies list is not empty
                // to update noData flag
                self.noTopRatedData = self.topRatedMovies.isEmpty
            }
            .store(in: &cancellables)
        
        // subscribe on Most Popular Movies service retrieved list
        mostPopularMovieService.$moviesList
            .sink {[weak self] (recievedMovies) in
                guard let self = self else {return}
                self.mostPopularMovies = recievedMovies
                // update Loading status
                self.isLoading = false
                // check if Most Popular Movies list is not empty
                // to update noData flag
                self.noMostPopularData = self.mostPopularMovies.isEmpty
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
    
    private func noDataInLists()->Bool{
        if topRatedMovies.isEmpty && mostPopularMovies.isEmpty{
            return true
        }
        return false
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
