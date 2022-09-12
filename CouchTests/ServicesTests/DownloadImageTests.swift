//
//  DownloadImageTests.swift
//  CouchTests
//
//  Created by Marina on 12/09/2022.
//

import XCTest
import Combine

@testable import Couch

class DownloadImageTests: XCTestCase {

    var testSubscriptions =  Set<AnyCancellable>()

    override func tearDown() {
        testSubscriptions = []
    }

    func testLoadingPosterImage() throws {
        let mockImagePath = "/9f5sIJEgvUpFv0ozfA6TurG4j22.jpg"
        let mockSize = "w185"
        let mockService = DownloadImageService(imagePath: mockImagePath, imageSize: mockSize)
        
        let promise =  expectation(description: "Loading Movie Poster Image")
        mockService.$image
            .sink { image in
                if image != nil {
                    promise.fulfill()
                }
            }
            .store(in: &testSubscriptions)
        wait(for: [promise], timeout: 2)
        
    }
    
    func testLoadingBackdropImage() throws{
        let mockImagePath = "/2RSirqZG949GuRwN38MYCIGG4Od.jpg"
        let mockSize = "w500"
        let mockService = DownloadImageService(imagePath: mockImagePath, imageSize: mockSize)
        
        let promise =  expectation(description: "Loading Movie Backdrop Image")
        mockService.$image
            .sink { image in
                if image != nil {
                    promise.fulfill()
                }
            }
            .store(in: &testSubscriptions)
        wait(for: [promise], timeout: 2)
    }
    
    func testLoadingImage_invalidSize () throws{
        let mockImagePath = "/2RSirqZG949GuRwN38MYCIGG4Od.jpg"
        let mockSize = "invalid"
        let mockService = DownloadImageService(imagePath: mockImagePath, imageSize: mockSize)
        
        let promise =  expectation(description: "Loading Movie invalid size Image")
        mockService.$image
            .sink { image in
                promise.fulfill()
            }
            .store(in: &testSubscriptions)
        wait(for: [promise], timeout: 2)
    }
    
    func testLoadingImage_invalidPath () throws{
        let mockImagePath = "/invalid"
        let mockSize = "w185"
        let mockService = DownloadImageService(imagePath: mockImagePath, imageSize: mockSize)
        
        let promise =  expectation(description: "Loading Movie invalid path Image")
        mockService.$image
            .sink { image in
                if image == nil {
                    promise.fulfill()
                }
            }
            .store(in: &testSubscriptions)
        wait(for: [promise], timeout: 2)
    }

}
