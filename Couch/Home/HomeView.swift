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
                
                FilterBarView(selectedItem: $viewModel.selectedListTypeIndex, barItems: viewModel.listTypesNames)
                
                moviesListView
                
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
    
    var moviesListView: some View{
        ZStack{
            switch viewModel.currentSorting{
            case .topRated:
                topRatedMoviesList
            case .mostPopular:
                mostPopularMoviesList
            }
        }
    }
    
    var topRatedMoviesList: some View{
        MoviesListView(movieList: $viewModel.topRatedMovies,
                       
                       loadMoreAction: {
            //viewModel.getMoreMovies()
        })
    }
    
    var mostPopularMoviesList: some View{
        MoviesListView(movieList: $viewModel.mostPopularMovies,
                       
                       loadMoreAction: {
            //viewModel.getMoreMovies()
        })
    }
    
    
}

struct FilterItem{
    var title: String
    var contentListView: MoviesListView
}


