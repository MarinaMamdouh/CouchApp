//
//  MovieGridCell.swift
//  Couch
//
//  Created by Marina on 06/09/2022.
//

import SwiftUI


struct MovieGridCell: View {
    @StateObject var viewModel: MovieGridCellViewModel
    @State var opacity = 1.0
    private let loadingAnimation = Animation.easeInOut(duration: 1)
    
    init(movie: MovieModel){
        _viewModel = StateObject(wrappedValue:  MovieGridCellViewModel(movieModel: movie))
    }
    
    var body: some View {
        VStack {
            if viewModel.isLoading{
                movieTextBox
            }
            movieImage
        }
        
    }
    
}

extension MovieGridCell{
    
    var movieTextBox: some View{
        Text(viewModel.movie.title)
            .posterImageSize()
            .loadingStyle()
            .font(.title2)
            .multilineTextAlignment(.center)
            .cornerRadius(10)
            .padding()
            .opacity(opacity)
            .onAppear(perform: startLoadingAnimation)
    }
    
    var movieImage: some View{
        VStack{
            if let image = viewModel.image{
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
            }
        }
    }
    
    func startLoadingAnimation(){
        withAnimation(
            Animation.easeInOut(duration:1).repeat(while:viewModel.isLoading))
        {
            opacity = 0.5
        }
    }
}

struct MovieGridCell_Preview: PreviewProvider {
    static var previews: some View {
        MovieGridCell(movie: PreviewData.movieModelExample)
            .previewLayout(.sizeThatFits)
    }
}


