//
//  HomeView.swift
//  Couch
//
//  Created by Marina on 05/09/2022.
//

import SwiftUI

struct HomeView: View {
    
    let filterBarItems = [ Constants.Texts.mostPopularFilterBarItem, Constants.Texts.topRatedFilterBarItem ]
    
    var body: some View {
            ZStack {
                Color.theme.background
                    .edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading){
                    header
                    
                    FilterBarView(barItems: filterBarItems)
                    
                    ContentListView()

                }
                
            }
        
    }
    
    func loadTopRatedView() -> some View{
        return ContentListView(viewModel: ContentListViewModel())
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
    var contentListView: ContentListView
}


