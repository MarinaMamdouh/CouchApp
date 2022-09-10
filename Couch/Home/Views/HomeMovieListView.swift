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
        MoviesListView(list: $viewModel.topRatedMovies, onScrollEnded: {
            viewModel.isLoading = true
        })
            
        
    }
    
    var mostPopularMoviesList: some View{
        MoviesListView(list: $viewModel.mostPopularMovies,
            onScrollEnded: {
                viewModel.isLoading = true
            })  
    }
}

struct HomeMovieListView_Previews: PreviewProvider {
    static var previews: some View {
        HomeMovieListView()
    }
}
