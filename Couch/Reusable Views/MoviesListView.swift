//
//  ContentView.swift
//  Couch
//
//  Created by Marina on 05/09/2022.
//

import SwiftUI

struct MoviesListView: View {
    
    @Binding var movieList: [MovieModel]
    @State var onScrollEnded: ()->()
    
    @State var selectedMovieIndex:Int = 0
    @State private var showMovieDetails:Bool = false
    @State private var isLoading: Bool = false
    
    private var pagination: Bool
    private var lastMovieIndex: Int{
        return movieList.count - 1
    }
    
    init(list: Binding<[MovieModel]>){
        _movieList = list
        onScrollEnded = {}
        pagination = false
    }

    init(list: Binding<[MovieModel]>, onScrollEnded: @escaping ()->()){
        _movieList = list
        self.onScrollEnded = onScrollEnded
        pagination = true
    }
    
    let columnsLayout = [
        GridItem(.adaptive(minimum: 150, maximum: Constants.ImageSizes.maxPosterSize.width), spacing: 20)
    ]
    
    var body: some View {
        ScrollView() {
            gridView
                
            if isLoading{
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
            .sheet(isPresented: $showMovieDetails) {
                MovieDetailsView(movie: movieList[selectedMovieIndex])
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
                if index == lastMovieIndex {
                    isLoading = pagination
                    onScrollEnded()
                }
                
            }
            .onTapGesture
            { onMovieSelected(of: index) }
    }
    
    func onMovieSelected(of index: Int){
        selectedMovieIndex = index
        showMovieDetails.toggle()
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




