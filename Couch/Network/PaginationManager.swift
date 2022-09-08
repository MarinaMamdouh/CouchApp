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
    private var totalPages:Int = -1 // total pages in server are not defined yet

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
        totalPages = totalPagesInServer
        currentPage = lastPageLoaded
    }
}
