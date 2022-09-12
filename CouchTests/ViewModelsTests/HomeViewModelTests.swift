//
//  HomeViewModelTests.swift
//  CouchTests
//
//  Created by Marina on 12/09/2022.
//

import XCTest
import Combine
@testable import Couch

class HomeViewModelTests: XCTestCase {
    var testSubscriptions =  Set<AnyCancellable>()

    override func tearDown() {
        testSubscriptions = []
    }

    func testLoadingViewModel() throws {
        let mockViewModel = HomeViewModel()
        var promise = expectation(description: "Loading HomeViewModel Most Popular movies")
        mockViewModel.$mostPopularMovies
            .sink { movies in
                if !movies.isEmpty  && movies.count == 20{
                    promise.fulfill()
                }
            }
            .store(in: &testSubscriptions)
        
        wait(for: [promise], timeout: 2)
        
        promise = expectation(description: "Loading HomeViewModel Top Rated Movies")
        mockViewModel.$topRatedMovies
            .sink { movies in
                if !movies.isEmpty && movies.count == 20{
                    promise.fulfill()
                }
            }
            .store(in: &testSubscriptions)
        wait(for: [promise], timeout: 2)
        
        promise = expectation(description: "Testing default selected Sorting")
        mockViewModel.$currentSorting
            .sink { type in
                if type == .mostPopular{
                    promise.fulfill()
                }
            }
            .store(in: &testSubscriptions)
        wait(for: [promise], timeout: 2)
    }
    
    func testChangingListType() throws{
        let mockViewModel = HomeViewModel()
        // select second filter item
        mockViewModel.selectedListTypeIndex = 1
        let promise = expectation(description: "HomeViewModel: Changing List Type to second item")
        mockViewModel.$currentSorting
            .sink { type in
                if type == mockViewModel.listTypes[1]{
                    promise.fulfill()
                }
            }
            .store(in: &testSubscriptions)
        wait(for: [promise], timeout: 1)
    }
    
    func testingHomeListTypes() throws{
        let listTypes:[ListType] = [.topRated, .mostPopular]
        let mockViewModel = HomeViewModel(listTypes: listTypes)
        let promise = expectation(description: "HomeViewModel: Changing default List Types")
        mockViewModel.$currentSorting
            .sink { type in
                if type == .topRated{
                    promise.fulfill()
                }
            }
            .store(in: &testSubscriptions)
        wait(for: [promise], timeout: 1)
    }
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
