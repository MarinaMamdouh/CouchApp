//
//  ContentView.swift
//  Couch
//
//  Created by Marina on 05/09/2022.
//

import SwiftUI

struct MoviesListView: View {
    @Binding var movieList: [MovieModel]
    @Binding var loadingMoreData: Bool
    @State var selectedMovieIndex:Int = 0
    @State var showDetails:Bool = false
    
    private var lastMovieIndex: Int{
        return movieList.count - 1
    }
    
    let columnsLayout = [
        GridItem(.adaptive(minimum: 150, maximum: Constants.ImageSizes.maxPosterSize.width), spacing: 20)
    ]
    
    var body: some View {
        ScrollView() {
            gridView
            if loadingMoreData{
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
            .sheet(isPresented: $showDetails) {
                MovieDetailsView(movie: movieList[selectedMovieIndex])
            }
            
            
        }
        .padding()
    }
    
    func cellView(_ index:Int)-> some View{
        MovieGridCell(movie: movieList[index])
           
            .onAppear{
                if index == lastMovieIndex {
                    loadingMoreData = true
                }
            }
            .onTapGesture
            { onMovieSelected(of: index) }
    }
    
    var progressView: some View{
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: Color.theme.primary))
            .padding()
            
    }
    
    func onMovieSelected(of index: Int){
        selectedMovieIndex = index
        showDetails.toggle()
    }
    
}

struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        MoviesListView(movieList: .constant(PreviewData.moviesListExample), loadingMoreData: .constant(true))
            .background(Color.theme.background)
            .previewLayout(.sizeThatFits)
    }
}



