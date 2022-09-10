//
//  TabBarView.swift
//  Couch
//
//  Created by Marina on 10/09/2022.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            TabView{
                HomeView()
                    .tabItem {
                        Label {
                            Text(Constants.Texts.home)
                        } icon: {
                            Image(systemName: Constants.Symbols.homeSymbol)
                        }
                    }
                FavoritesView()
                    .tabItem {
                        Label {
                            Text(Constants.Texts.favorites)
                        } icon: {
                            Image(systemName: Constants.Symbols.heartFillSymbol)
                        }
                    }
            }
            .onAppear {
                UITabBar.appearance().barTintColor = UIColor(Color.theme.accent)
                UITabBar.appearance().backgroundColor = UIColor(Color.theme.background)
            }
        }
    }
    
    var homeView: some View{
        HomeView()
    }
    
    var favorites: some View{
        FavoritesView()
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
