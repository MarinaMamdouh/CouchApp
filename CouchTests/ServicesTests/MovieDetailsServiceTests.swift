//
//  MovieDetailsServiceTests.swift
//  CouchTests
//
//  Created by Marina on 12/09/2022.
//

import XCTest
import Combine

@testable import Couch

class MovieDetailsServiceTests: XCTestCase {

    var testSubscriptions =  Set<AnyCancellable>()

    override func tearDown() {
        testSubscriptions = []
    }

    func testLoadingMovieDetails() throws {
        let mockMovie = PreviewData.movieModelExample
        let mockService = MovieDetailsService(movie: mockMovie)
        
        let promise =  expectation(description: "Loading Movie Details Service")
        mockService.$movieDetails
            .sink { details in
                if details != nil && details?.id == mockMovie.id{
                    promise.fulfill()
                }
            }
            .store(in: &testSubscriptions)
        wait(for: [promise], timeout: 2)
        
    }
    
    func testLoadingMovieDetails_invalidId () throws{
        let mockMovie = MovieModel(id: -1, originalTitle: "", title: "", posterPath: "")
        let mockService = MovieDetailsService(movie: mockMovie)
        
        let promise =  expectation(description: "Loading Movie Details Service. Invalid Id")
        mockService.$movieDetails
            .sink { details in
                if details ==  nil{
                    promise.fulfill()
                }
            }
            .store(in: &testSubscriptions)
        wait(for: [promise], timeout: 2)
    }

}
