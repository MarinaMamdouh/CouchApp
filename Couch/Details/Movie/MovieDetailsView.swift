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
            Color(Constants.UIColors.defaultBackgroundColor)
                .ignoresSafeArea()
            ScrollView {
                VStack{
                    Image("DefaultBackdrop")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .opacity(0.8)
                        .shadow(color: .black, radius: 30, x: 0, y: 5)
                    Text(movieDetails.originalTitle)
                        .padding(.top)
                        .foregroundColor(.white)
                        .font(.title)
                    
                    Text("(\(movieDetails.releaseDate))")
                        .foregroundColor(.white)
                        .font(.title2)
                    Text(movieDetails.genres)
                        .foregroundColor(Color(UIColor.lightGray))
                        .padding(.all, 5)
                        .font(.title3)
                    
                    HStack(spacing: 10){
                        Image(systemName: "star.fill")
                            .font(.title2)
                            .foregroundColor(.orange)
                            
                        Text("\(movieDetails.rating)/ 10")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .bold, design: .default))
                    }
                    
                    Text(movieDetails.overView)
                        .padding()
                        .foregroundColor(.gray)
                        .font(.body)
                    Spacer()
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

struct MovieDetails{
    
    var originalTitle: String
    var backdropImage: String
    var overView: String
    var rating: String
    var releaseDate: String
    var genres: String
}

extension MovieDetails{
    static let example:MovieDetails = MovieDetails(originalTitle: "Thor: Love and Thunder", backdropImage: "", overView: "After his retirement is interrupted by Gorr the God Butcher, a galactic killer who seeks the extinction of the gods, Thor Odinson enlists the help of King Valkyrie, Korg, and ex-girlfriend Jane Foster, who now inexplicably wields Mjolnir as the Relatively Mighty Girl Thor. Together they embark upon a harrowing cosmic adventure to uncover the mystery of the God Butcher’s vengeance and stop him before it’s too late.", rating: "6.7", releaseDate: "2022", genres: "Action, Adventure, Fantasy")
}
