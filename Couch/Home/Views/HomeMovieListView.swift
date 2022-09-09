//
//  HomeMovieListView.swift
//  Couch
//
//  Created by Marina on 09/09/2022.
//

import SwiftUI

struct HomeMovieListView: View {
    @EnvironmentObject var viewModel:HomeViewModel
    var body: some View {
        HStack{
            switch viewModel.currentSorting{
            case .topRated:
                topRatedMoviesList
            case .mostPopular:
                mostPopularMoviesList
            }
        }
    }
    
    var topRatedMoviesList: some View{
        MoviesListView(movieList: $viewModel.topRatedMovies, loadingMoreData: $viewModel.isLoading)
        
    }
    
    var mostPopularMoviesList: some View{
        MoviesListView(movieList: $viewModel.mostPopularMovies, loadingMoreData: $viewModel.isLoading)
            
    }
}

struct HomeMovieListView_Previews: PreviewProvider {
    static var previews: some View {
        HomeMovieListView()
    }
}
