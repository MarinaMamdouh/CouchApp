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
        VStack{
            if viewModel.noData{
                progressView
            }else{
                switch viewModel.currentSorting{
                case .topRated:
                    topRatedMoviesList
                case .mostPopular:
                    mostPopularMoviesList
                }
            }
            
        }
    }
    
    var progressView: some View{
        VStack {
            Spacer()
            HStack {
                Spacer()
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.theme.primary))
                .padding()
                Spacer()
            }
            Spacer()
        }
        
    }
    
    
    var topRatedMoviesList: some View{
        MoviesListView(list: $viewModel.topRatedMovies, enableDetails: true, onScrollEnded: {
            viewModel.isLoading = true
        })
        
        
    }
    
    var mostPopularMoviesList: some View{
        MoviesListView(list: $viewModel.mostPopularMovies, enableDetails: true,
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
