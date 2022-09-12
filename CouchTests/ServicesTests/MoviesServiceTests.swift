//
//  MoviesServiceTests.swift
//  CouchTests
//
//  Created by Marina on 12/09/2022.
//

import XCTest
import Combine

@testable import Couch

class MoviesServiceTests: XCTestCase {
    
    var testSubscriptions =  Set<AnyCancellable>()

    override func tearDown() {
        testSubscriptions = []
    }

    func testLoadingMostPopularMovies() throws {
        // load First Patch
        let mock = MoviesService(listType: .mostPopular)
        
        let promise =  expectation(description: "Loading Most Popular movies")
        mock.$moviesList
            .sink { movies in
                if !movies.isEmpty && movies.count == 20{
                    promise.fulfill()
                }
            }
            .store(in: &testSubscriptions)
        wait(for: [promise], timeout: 1)
        
        
    }
    
    func testLoadingTopRatedMovies() throws {
        // load First Patch
        let mock = MoviesService(listType: .topRated)
        
        let promise =  expectation(description: "Loading Top Rated movies")
        mock.$moviesList
            .sink { movies in
                if !movies.isEmpty && movies.count == 20{
                    promise.fulfill()
                }
            }
            .store(in: &testSubscriptions)
        wait(for: [promise], timeout: 1)
        
        
    }
    
    func testLoadingMostPopularMovies_WithPaginationManager() throws {
        // load First Patch
        // inject a Pagination Manager
        let mockPaginationManager =  PaginationManager()
        let mock = MoviesService(listType: .mostPopular, pagination: mockPaginationManager)
        
        let promise =  expectation(description: "Loading Most Popular movies with Pagination Manager")
        mock.$moviesList
            .sink { movies in
                if !movies.isEmpty && movies.count == 20{
                    let nextPage = mockPaginationManager.getNextPage()
                    if nextPage == 2 {
                        promise.fulfill()
                    }
                }
            }
            .store(in: &testSubscriptions)
        wait(for: [promise], timeout: 1)
        
        
    }
    
    func testLoadingTopRatedMovies_WithPaginationManager() throws {
        // load First Patch
        // inject a Pagination Manager
        let mockPaginationManager =  PaginationManager()
        let mock = MoviesService(listType: .topRated, pagination: mockPaginationManager)
        
        let promise =  expectation(description: "Loading Top Rated movies with Pagination Manager")
        mock.$moviesList
            .sink { movies in
                if !movies.isEmpty && movies.count == 20{
                    let nextPage = mockPaginationManager.getNextPage()
                    if nextPage == 2 {
                        promise.fulfill()
                    }
                }
            }
            .store(in: &testSubscriptions)
        wait(for: [promise], timeout: 1)
        
    }
    

}
