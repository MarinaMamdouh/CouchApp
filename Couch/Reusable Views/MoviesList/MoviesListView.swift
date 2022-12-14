//
//  ContentView.swift
//  Couch
//
//  Created by Marina on 05/09/2022.
//

import SwiftUI

struct MoviesListView: View {
    
    @Binding var movieList: [MovieModel]
    @StateObject var viewModel:MoviesListViewModel
    
    init(list: Binding<[MovieModel]>, showFavorite: Bool){
        _movieList = list
        _viewModel =  StateObject(wrappedValue: MoviesListViewModel(showFavorite: showFavorite))
        
    }
    
    init(list: Binding<[MovieModel]> , showFavorite: Bool, onScrollEnded: @escaping ()->()){
        _movieList = list
        _viewModel =  StateObject(wrappedValue: MoviesListViewModel(showFavorite: showFavorite, onSelectedAction: onScrollEnded))
    }
    
    private let columnsLayout = [
        GridItem(.adaptive(minimum: 150, maximum: Constants.ImageSizes.maxPosterSize.width), spacing: 20)
    ]
    
    var body: some View {
        ScrollView() {
            gridView
            
            if viewModel.isLoading{
                progressView
            }
        }
        .sheet(isPresented: $viewModel.showMovieDetails) {
            if let selectedMovie = viewModel.selectedMovie{
                MovieDetailsView(movie: selectedMovie, showFavorite: viewModel.showFavorite)
            }
        }
    }
    
}


extension MoviesListView{
    
    var gridView: some View{
        LazyVGrid(columns: columnsLayout, spacing: 20) {
            ForEach(movieList.indices, id: \.self) { index in
                    cellView(index)
            }
        }
        
    }
    
    
    var progressView: some View{
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: Color.theme.primary))
            .padding()
        
    }
    
    // get movie cell View for a given index
    func cellView(_ index:Int)-> some View{
        MovieGridCell(movie: movieList[index])
            .onAppear{
                viewModel.numberOfMovies = movieList.count
                viewModel.currentDisplayedIndex = index
            }
        
            .onTapGesture{
            viewModel.selectedMovie = movieList[index]
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group{
            
            // without Pagination
            MoviesListView(list: .constant(PreviewData.moviesListExample), showFavorite: true)
                .background(Color.theme.background)
                .previewLayout(.sizeThatFits)
            
            // with Pagination (we expect to see loading indicator at the end of scrolling)
            MoviesListView(list: .constant(PreviewData.moviesListExample), showFavorite: true, onScrollEnded: {})
                .background(Color.theme.background)
                .previewLayout(.sizeThatFits)
        }
    }
}




