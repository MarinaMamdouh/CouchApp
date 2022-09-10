//
//  FavoritesView.swift
//  Couch
//
//  Created by Marina on 10/09/2022.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject var viewModel =  FavoritesViewModel()
    var body: some View {
        NavigationView {
            ZStack {
                Color.theme.background
                    .ignoresSafeArea()
                VStack{
                    header
                    
                    content
                }
            }
            .navigationTitle(Constants.Texts.favorites)
            .navigationBarHidden(true)
        }
    }
    
    var header: some View{
        HStack {
            Text(Constants.Texts.favorites)
                .font(.largeTitle.bold())
                .foregroundColor(Color.theme.primary)
                .padding(20)
            Spacer()
        }
    }
    
    var content: some View{
        VStack{
            if viewModel.favMovies.isEmpty{
                emptyFav
                Spacer()
            }else{
                MoviesListView(list: $viewModel.favMovies)
            }
           
        }
    }
    
    var emptyFav: some View{
        VStack{
            HStack{
                
            }
            .background(Color.theme.background)
            .frame(height: 100)
            Text("No Favorite Movies Yet.")
                .font(.title)
                .foregroundColor(Color.theme.secondary)
                .padding()
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
