//
//  HomeView.swift
//  Couch
//
//  Created by Marina on 05/09/2022.
//

import SwiftUI

struct HomeView: View {
    
    let backgroundColor = Constants.UIColors.defaultBackgroundColor
    
    let filterBarItems = [ Constants.Texts.mostPopularFilterBarItem, Constants.Texts.topRatedFilterBarItem ]
    
    init() {
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.barTintColor = .black
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(backgroundColor).edgesIgnoringSafeArea(.all)
                VStack{
                    FilterBarView(barItems: filterBarItems)
                        .padding()
                    ContentListView()
                        .padding(.top, 20)

                }
                .navigationBarTitle(Constants.Texts.moviesTitle)
                
            }
        }
        
    }
    
    func loadTopRatedView() -> some View{
        return ContentListView(viewModel: ContentListViewModel())
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct FilterItem{
    var title: String
    var contentListView: ContentListView
}


