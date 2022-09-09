//
//  MovieDetailsView.swift
//  Couch
//
//  Created by Marina on 05/09/2022.
//

import SwiftUI

struct MovieDetailsView: View {
    var movieDetails = MovieDetails.example
    var body: some View {
        ZStack{
            Color.theme.background
                .ignoresSafeArea()
            ScrollView {
                VStack{
                    movieImage
                    
                    movieTitle
                    
                    movieYear
                    
                    movieGenres
                    
                    movieRating
                    
                    moviePlot
                    
                    movieDuration
                }
            }
        }
    }
}

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsView()
    }
}

extension MovieDetailsView{
    var movieImage: some View{
        Image("DefaultBackdrop")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .opacity(0.8)
            .shadow(color: .black, radius: 30, x: 0, y: 5)
    }
    
    var movieTitle: some View{
        Text(movieDetails.originalTitle)
            .padding(.top)
            .foregroundColor(Color.theme.primary)
            .font(.largeTitle)
    }
    
    var movieYear: some View{
        Text("(\(movieDetails.releaseDate))")
            .foregroundColor(Color.theme.primary)
            .font(.title)
    }
    
    var movieGenres: some View{
        Text(movieDetails.genres)
            .foregroundColor(Color.theme.secondary)
            .padding(.all, 5)
            .font(.title2)
    }
    
    var movieRating: some View{
        HStack(spacing: 010){
            Image(systemName: Constants.Symbols.starFillSymbol)
                .font(.title2)
                .foregroundColor(Color.theme.accent)
            
            Text("\(movieDetails.rating)/ 10")
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
            Text(movieDetails.overView)
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
            Text("\(movieDetails.runTime) mins")
                .foregroundColor(Color.theme.secondary)
                .font(.title3)
            Spacer()
        }
    }
}

struct MovieDetails{
    
    var originalTitle: String
    var backdropImage: String
    var overView: String
    var rating: String
    var releaseDate: String
    var genres: String
    var runTime: Int
}


extension MovieDetails{
    static let example:MovieDetails = MovieDetails(originalTitle: "Thor: Love and Thunder", backdropImage: "", overView: "After his retirement is interrupted by Gorr the God Butcher, a galactic killer who seeks the extinction of the gods, Thor Odinson enlists the help of King Valkyrie, Korg, and ex-girlfriend Jane Foster, who now inexplicably wields Mjolnir as the Relatively Mighty Girl Thor. Together they embark upon a harrowing cosmic adventure to uncover the mystery of the God Butcher’s vengeance and stop him before it’s too late.", rating: "6.7", releaseDate: "2022", genres: "Action, Adventure, Fantasy", runTime: 119)
}
