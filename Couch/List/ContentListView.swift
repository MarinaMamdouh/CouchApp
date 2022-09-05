//
//  ContentView.swift
//  Couch
//
//  Created by Marina on 05/09/2022.
//

import SwiftUI

struct ContentListView: View {
    @StateObject var viewModel = ContentListViewModel()
    let defaultImage = UIImage(named: "DefaultImage")!
    let columnsLayout = [
        GridItem(.adaptive(minimum: 150, maximum: 185), spacing: 20)
    ]
    var body: some View {
            ScrollView() {
                LazyVGrid(columns: columnsLayout, spacing: 20) {
                    
                    ForEach(0...viewModel.contentList.count - 1, id: \.self) { index in
                        
                        ContentGridCell(title: viewModel.contentList[index].title, contentImage:defaultImage)
                            .onAppear{
                                viewModel.loadMoreIfPossible(index)
                            }

                    }
                    
                }
                .padding(.horizontal, 10.0)
                if viewModel.isLoading{
                    ProgressView()
                        .padding()
                }
            }
    }
    
}

struct ContentGridCell: View {
    @State var title: String
    @State var contentImage: UIImage
    var body: some View {
        ZStack {
            Text(title)
            Image(uiImage: contentImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
        }.background(Color.blue)
            .cornerRadius(10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentListView()
    }
}


