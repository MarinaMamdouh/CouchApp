//
//  HomeView.swift
//  Couch
//
//  Created by Marina on 05/09/2022.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    let filterBarItems = [ Constants.Texts.mostPopularFilterBarItem : ListType.mostPopular , Constants.Texts.topRatedFilterBarItem : ListType.topRated ]
    
    var body: some View {
        ZStack {
            Color.theme.background
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading){
                header
                
                FilterBarView(barItems: Array(filterBarItems.keys), itemIsSelected: { selectedItem in
                    chooseList(selectedItem)
                })
                
                MoviesListView(movieList: $viewModel.moviesList,
                               
                loadMoreAction: {
                    viewModel.getMoreMovies()
                })
                
            }
            
        }
        
    }
    
    func chooseList(_ selectedIndex:Int){
        let allKeys = Array(filterBarItems.keys)
        let key =  allKeys[selectedIndex]
        let selectedListType = filterBarItems[key] ?? .mostPopular
        viewModel.currentSorting = selectedListType
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            HomeView()
                .navigationBarHidden(true)
        }
        
    }
}

extension HomeView{
    var header: some View{
        Text(Constants.Texts.moviesTitle)
            .padding()
            .foregroundColor(Color.theme.primary)
            .font(.largeTitle.bold())
    }
    
    
}

struct FilterItem{
    var title: String
    var contentListView: MoviesListView
}


