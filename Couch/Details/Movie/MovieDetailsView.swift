//
//  MovieDetailsView.swift
//  Couch
//
//  Created by Marina on 05/09/2022.
//

import SwiftUI

struct MovieDetailsView: View {
    @StateObject var viewModel: MovieDetailsViewModel
    let defaultImage = Image(systemName: "video.fill")
    @State var opacity = 0.8
    private let loadingAnimation = Animation.easeInOut(duration: 1)
    
    init(movie: MovieModel){
        _viewModel = StateObject(wrappedValue:  MovieDetailsViewModel(movie: movie))
    }
    
    init(details: MovieDetailsModel){
        _viewModel =  StateObject(wrappedValue: MovieDetailsViewModel(movieDetails: details))
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
            }
        }
    }
}



extension MovieDetailsView{
    var movieImage: some View{
        VStack{
            
            if let image = viewModel.movieBackdrop {
                Image(uiImage:  image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .shadow(color: .black, radius: 30, x: 0, y: 5)
            }else{
                loadingImageBox
            }
        }
        
    }
    
    var loadingImageBox: some View{
        Rectangle()
            .backDropImageSize()
            .loadingStyle()
            .cornerRadius(10)
            .opacity(opacity)
            .onAppear{
                startLoadingAnimation()
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
            .padding(.top)
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
            .padding(.all, 5)
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
    
    func startLoadingAnimation(){
        withAnimation(
            loadingAnimation.repeatForever(autoreverses: true))
        {
            opacity = 0.3
        }
    }
}

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsView(movie: PreviewData.movieModelExample)
    }
}


