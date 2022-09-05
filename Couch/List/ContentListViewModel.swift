//
//  ContentListViewModel.swift
//  Couch
//
//  Created by Marina on 05/09/2022.
//

import Foundation

class ContentListViewModel: ObservableObject{
    @Published var contentList:[Content]
    @Published private(set) var isLoading = false
    //TODO: add API property
    private var offset = 0
    private let totalPages = 100
    private let pageSize = 10
    init(){
        contentList = (1...10).map { i in
            Content(id: i, title: "Movies \(i)", posterPath: "")
        }
        offset = pageSize
    }
    
    func loadMoreIfPossible(_ displayedIndex: Int){
        let lastIndex = contentList.count - 1
        // check if view has displayed all the current loaded content list
        if displayedIndex < lastIndex{
            return
        }
        // check if we loaded all the pages in server
        if offset >= (totalPages * pageSize){
            return
        }
        isLoading = true
        // get more data as view displayed all the loaded data and there is more pages in the server
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            let start = self.offset + 1
            let end = self.offset + 10
            let newContent = (start...end).map { i in
                Content(id: i, title: "Movies \(i)", posterPath: "")
            }
            self.contentList.append(contentsOf: newContent)
            self.offset += self.pageSize
            self.isLoading = false
        }
       
    }
}

struct Content{
    var id: Int
    var title: String
    var posterPath: String
}
