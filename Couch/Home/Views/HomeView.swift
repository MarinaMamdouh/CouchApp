//
//  HomeView.swift
//  Couch
//
//  Created by Marina on 05/09/2022.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    var body: some View {
        NavigationView {
            ZStack {
                Color.theme.background
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading){
                    header
                    
                    sortingBar
                    
                    HomeMovieListView()
                }
                .navigationBarHidden(true)
                //.navigationTitle(Constants.Texts.moviesTitle)
            }
            .environmentObject(viewModel)
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
    
    var sortingBar: some View{
        FilterBarView(selectedItem: $viewModel.selectedListTypeIndex, barItems: viewModel.listTypesNames)
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


