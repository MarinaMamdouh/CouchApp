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
    
    init(list: Binding<[MovieModel]>){
        _movieList = list
        _viewModel =  StateObject(wrappedValue: MoviesListViewModel())
        
    }
    
    init(list: Binding<[MovieModel]>, onScrollEnded: @escaping ()->()){
        _movieList = list
        _viewModel =  StateObject(wrappedValue: MoviesListViewModel(onSelectedAction: onScrollEnded))
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
    }
    
}


extension MoviesListView{
    
    var gridView: some View{
        LazyVGrid(columns: columnsLayout, spacing: 20) {
            ForEach(movieList.indices, id: \.self) { index in
                cellView(index)
            }
            .sheet(isPresented: $viewModel.showMovieDetails) {
                if let movie = viewModel.selectedMovie {
                    MovieDetailsView(movie: movie)
                }
            }
            
            
        }
        .padding()
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
            MoviesListView(list: .constant(PreviewData.moviesListExample))
                .background(Color.theme.background)
                .previewLayout(.sizeThatFits)
            
            // with Pagination (we expect to see loading indicator at the end of scrolling)
            MoviesListView(list: .constant(PreviewData.moviesListExample), onScrollEnded: {})
                .background(Color.theme.background)
                .previewLayout(.sizeThatFits)
        }
    }
}




