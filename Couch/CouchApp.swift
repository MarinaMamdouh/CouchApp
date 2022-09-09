//
//  CouchApp.swift
//  Couch
//
//  Created by Marina on 05/09/2022.
//

import SwiftUI

@main
struct CouchApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView{
                HomeView()
                    .navigationBarHidden(true)
            }
        }
    }
}

//"Movies" = "Movies";
//"TopRated" = "Top Rated";
//"MostPopular" = "Most Popular";
//"ThePlot" = "The Plot";
//"Duration" = "Duration";
//"minutes" = "minutes";
