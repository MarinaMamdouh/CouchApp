//
//  ContentView.swift
//  Couch
//
//  Created by Marina on 05/09/2022.
//

import SwiftUI

struct MoviesListView: View {

    @Binding var movieList: [MovieModel]
    var loadMoreAction: () -> Void
    
    let columnsLayout = [
        GridItem(.adaptive(minimum: 150, maximum: 185), spacing: 20)
    ]
    var body: some View {
        ScrollView() {
            gridView
            
                progressView
        }
    }
    
}


extension MoviesListView{

    var gridView: some View{
        LazyVGrid(columns: columnsLayout, spacing: 20) {
            ForEach(movieList.indices, id: \.self) { index in
                
                MovieGridCell(movie: movieList[index])
                    .onAppear{
                        if index == movieList.count - 1{
                            
                            loadMoreAction()
                        }
                    }
                
            }
            
        }
        .padding(.horizontal, 10.0)
    }
    
    var progressView: some View{
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: Color.theme.primary))
            .padding()
            
    }
    
}

struct ContentView_Previews: PreviewProvider {
   static var contentList = (1...10).map { i in
        MovieModel(id: i, originalTitle: "Movie \(i)", title: "Movie \(i)", posterPath: "")
    }
    static var previews: some View {
        MoviesListView(movieList: .constant(contentList), loadMoreAction:{
            
        })
            .background(Color.theme.background)
            .previewLayout(.sizeThatFits)
    }
    
    static func loadMore(){
        let start = contentList.count
        let newContentList = (start...start + 10).map { i in
            MovieModel(id: i, originalTitle: "Movie \(i)", title: "Movie \(i)", posterPath: "")
        }
        contentList.append(contentsOf: newContentList)
    }
}



