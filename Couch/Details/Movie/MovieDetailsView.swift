//
//  MovieDetailsView.swift
//  Couch
//
//  Created by Marina on 05/09/2022.
//

import SwiftUI

struct MovieDetailsView: View {
    @StateObject var viewModel: MovieDetailsViewModel
    
    init(movie: MovieModel, showFavorite: Bool){
        _viewModel = StateObject(wrappedValue:  MovieDetailsViewModel(movie: movie, showFavorite: showFavorite))
        self.loadNavigationBarStyle()
    }
    
    init(details: MovieDetailsModel, showFavorite: Bool){
        _viewModel =  StateObject(wrappedValue: MovieDetailsViewModel(movieDetails: details, showFavorite: showFavorite))
        self.loadNavigationBarStyle()
    }
    
    var body: some View {
        ZStack{
            Color.theme.background
                .ignoresSafeArea()
            ScrollView {
                VStack{
                    movieImage
                    
                    movieDetails
                    
                }
                .padding(.bottom)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}



extension MovieDetailsView{
    var movieImage: some View{
        ZStack(alignment: .topTrailing) {
            BackdropMovieImage(image: $viewModel.movieBackdrop)
            
            if viewModel.showFavorite{
                favoriteIcon
            }
        }
        
    }
    
    var favoriteIcon: some View{
        
        FavoriteIcon(isOn: $viewModel.isFavorite)
            .onTapGesture {
                viewModel.isFavorite.toggle()
            }
        
    }
    
    var movieDetails: some View{
        VStack{
            movieTitle
            movieYear
            movieGenres
            movieRating
            moviePlot
            movieDuration
        }
    }
    
    var movieTitle: some View{
        Text(viewModel.details?.originalTitle ?? viewModel.movie?.title ?? "")
            .padding([.top,.leading, .trailing])
            .multilineTextAlignment(.center)
            .foregroundColor(Color.theme.primary)
            .font(.largeTitle)
    }
    
    var movieYear: some View{
        Text(viewModel.details?.releaseYear ?? "")
            .foregroundColor(Color.theme.primary)
            .font(.title)
    }
    
    var movieGenres: some View{
        Text(viewModel.details?.genres ?? "")
            .foregroundColor(Color.theme.secondary)
            .padding(.vertical, 5)
            .padding(.horizontal)
            .font(.title2)
            .multilineTextAlignment(.center)
    }
    
    var movieRating: some View{
        HStack(spacing: 10){
            Image(systemName: Constants.Symbols.starFillSymbol)
                .font(.title2)
                .foregroundColor(Color.theme.accent)
            
            Text("\(viewModel.details?.rating ?? "0")/ 10")
                .foregroundColor(Color.theme.primary)
                .font(.system(size: 20, weight: .bold, design: .default))
            
        }
    }
    
    var moviePlot: some View{
        VStack{
            HStack{
                Text(Constants.Texts.plotTitle)
                    .padding()
                    .foregroundColor(Color.theme.primary)
                    .font(.title)
                Spacer()
            }
            Text(viewModel.details?.overView ?? "")
                .padding([.leading, .trailing])
                .foregroundColor(Color.theme.secondary)
                .font(.body)
        }
    }
    
    var movieDuration: some View{
        HStack{
            Text("\(Constants.Texts.duration) :")
                .padding(.leading)
                .padding([.bottom, .top], 10)
                .foregroundColor(Color.theme.accent)
                .font(.title3)
            Text("\(viewModel.details?.runTime ?? 0) mins")
                .foregroundColor(Color.theme.secondary)
                .font(.title3)
            Spacer()
        }
    }

    
}

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsView(movie: PreviewData.movieModelExample, showFavorite: true)
    }
}


