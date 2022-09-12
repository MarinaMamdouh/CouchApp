//
//  HomeMovieListView.swift
//  Couch
//
//  Created by Marina on 09/09/2022.
//

import SwiftUI

struct HomeMoviesListView: View {
    @EnvironmentObject var viewModel:HomeViewModel
    var body: some View {
        VStack{
            moviesList
        }
        .padding(.horizontal)
    }
}

extension HomeMoviesListView{
    
    var moviesList: some View{
        VStack{
            switch viewModel.currentSorting{
            case .topRated:
                topRatedMoviesList
            case .mostPopular:
                mostPopularMoviesList
            }
        }
    }
    
    var progressView: some View{
        VStack (alignment: .center){
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: Color.theme.primary))
                .padding()
            Spacer()
        }
        .frame(maxWidth: .infinity)
        
    }
    
    
    var topRatedMoviesList: some View{
        VStack{
            if viewModel.noTopRatedData{
                progressView
            }else{
                MoviesListView(list: $viewModel.topRatedMovies, showFavorite: true, onScrollEnded: {
                    viewModel.isLoading = true
                })
            }
        }
        
        
    }
    
    var mostPopularMoviesList: some View{
        VStack{
            if viewModel.noMostPopularData{
                progressView
            }else{
                MoviesListView(list: $viewModel.mostPopularMovies, showFavorite: true,
                               onScrollEnded: {
                    viewModel.isLoading = true
                })
            }
        }
    }
}

struct HomeMovieListView_Previews: PreviewProvider {
    static var previews: some View {
        HomeMoviesListView()
    }
}
