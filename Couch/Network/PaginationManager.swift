//
//  PaginationManager.swift
//  Couch
//
//  Created by Marina on 08/09/2022.
//

import Foundation

// To handle different kinds of Paginations in the future
protocol Pagination{
    
    func getNextPage()-> Int?
    
    func save(totalPagesInServer: Int, lastPageLoaded:Int)
    
}

// Our Main Basic PaginationManager
class PaginationManager: Pagination{
    private var currentPage:Int = 0
    private let maxPages:Int = 500 // limit of moviedb pages
    private var totalPages:Int = 0
    init(){
        totalPages = maxPages
    }
    func getNextPage()-> Int?{
        let nextPage = currentPage + 1
        // check if nextPage is out of totalPages in the server range
        // make sure if it is the first time getting a page we don't know the totalpage is yet
        // so we make sure that our total pages is not equal to -1 (indicates not defined yet)
        if nextPage > totalPages && totalPages != -1 {
            return nil
        }
        currentPage = nextPage
        return nextPage
    }
    
    func save(totalPagesInServer: Int, lastPageLoaded:Int){
        currentPage = lastPageLoaded
        // Readjust the total pages to not exceed the maxPages limit to not retrieve API bad response
        // if totalPagesInServer is greater than the maxPages then
        // totalPages = maxPages else
        // totalPages = totalPagesInServer
        totalPages = min(totalPagesInServer, maxPages)
    }
}
