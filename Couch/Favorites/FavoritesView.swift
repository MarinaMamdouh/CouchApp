//
//  FavoritesView.swift
//  Couch
//
//  Created by Marina on 10/09/2022.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject var viewModel =  FavoritesViewModel()
    
    init(){
        self.loadNavigationBarStyle()
    }
    
    var body: some View {
            ZStack {
                Color.theme.background
                    .ignoresSafeArea()
                
                favoritesList
            }
            .navigationTitle(Constants.Texts.favorites)
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
    
    var favoritesList: some View{
        VStack{
            if viewModel.favMovies.isEmpty{
                emptyFavoritesMessage
                
            }else{
                MoviesListView(list: $viewModel.favMovies, showFavorite: false)
                    .padding()
            }
        }
        
    }
    
    var emptyFavoritesMessage: some View{
        VStack{
            Text(Constants.Texts.emptyFavorites)
                .font(.title)
                .foregroundColor(Color.theme.secondary)
                .padding()
                .padding(.top, 100)
            Spacer()
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
