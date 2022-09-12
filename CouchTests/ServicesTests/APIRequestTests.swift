//
//  APIRequestTests.swift
//  CouchTests
//
//  Created by Marina on 11/09/2022.
//

import XCTest
@testable import Couch

class APIRequestTests: XCTestCase {
    
    let topRatedEndPoint = "https://api.themoviedb.org/3/movie/top_rated"
    let mostPopularEndPoint = "https://api.themoviedb.org/3/movie/popular"
    let movieDetailsEndPoint = "https://api.themoviedb.org/3/movie"
    let imageEndPoint = "https://image.tmdb.org/t/p"
    
    let apiKey =  Constants.APIs.apiKeyParameter.value!
    let commonParameters = "language=en-US&region=US"

    func test_TopRatedAP_normalCases() throws {
        
        var commonURL  = "\(topRatedEndPoint)" + "?"
        commonURL += "api_key=\(apiKey)&"
        commonURL += "\(commonParameters)&"
        
        var page = 1
        var api = APIRequest.getTopRatedMovies(page)
        var resultRequest = api.asRequest()
        
        var expectedURL = "\(commonURL)" + "page=\(page)"
        XCTAssertNotNil(resultRequest, "Top Rated Request should not be nil.")
        XCTAssertNotNil(resultRequest.url, "Top Rated URL should not be nil.")
        XCTAssertEqual(resultRequest.url?.absoluteString, expectedURL, "Top Rated URl is matching the expected \(expectedURL)")
        
        page = 10
        api = APIRequest.getTopRatedMovies(page)
        resultRequest = api.asRequest()
        expectedURL = "\(commonURL)" + "page=\(page)"
        XCTAssertNotNil(resultRequest, "Top Rated Request should not be nil.")
        XCTAssertNotNil(resultRequest.url, "Top Rated URL should not be nil.")
        XCTAssertEqual(resultRequest.url?.absoluteString, expectedURL, "Top Rated URl is matching the expected \(expectedURL)")
    }
    
    func test_MostPopular_normalCases() throws{
        var commonURL  = "\(mostPopularEndPoint)" + "?"
        commonURL += "api_key=\(apiKey)&"
        commonURL += "\(commonParameters)&"
        
        var page = 1
        var api = APIRequest.getMostPopularMovies(page)
        var resultRequest = api.asRequest()
        
        var expectedURL = "\(commonURL)" + "page=\(page)"
        XCTAssertNotNil(resultRequest, "Most popular Request should not be nil.")
        XCTAssertNotNil(resultRequest.url, "Most popular URL should not be nil.")
        XCTAssertEqual(resultRequest.url?.absoluteString, expectedURL, "Most popular URl is matching the expected \(expectedURL)")
        
        page = 10
        api = APIRequest.getMostPopularMovies(page)
        resultRequest = api.asRequest()
        expectedURL = "\(commonURL)" + "page=\(page)"
        XCTAssertNotNil(resultRequest, "Most popular Request should not be nil.")
        XCTAssertNotNil(resultRequest.url, "Most popular URL should not be nil.")
        XCTAssertEqual(resultRequest.url?.absoluteString, expectedURL, "Most popular URl is matching the expected \(expectedURL)")
    }
    
    
    func test_movieDetailsAPI_normalCases(){
        let id = 123
        var expectedURL  = "\(movieDetailsEndPoint)" + "/\(id)?"
        expectedURL += "api_key=\(apiKey)&language=en-US"
        
        let api = APIRequest.getMovieDetails(id)
        let resultRequest = api.asRequest()
        XCTAssertNotNil(resultRequest, "Movie Details Request should not be nil.")
        XCTAssertNotNil(resultRequest.url, "Movie Details URL should not be nil.")
        XCTAssertEqual(resultRequest.url?.absoluteString, expectedURL, "Movie Details URl is matching the expected \(expectedURL)")
        
    }
    
    func test_imageAPI_PosterImage(){
        let path = "/9f5sIJEgvUpFv0ozfA6TurG4j22.jpg"
        let size = "w185"
        var expectedURL  = "\(imageEndPoint)"
        expectedURL += "/\(size)"
        expectedURL += "/\(path)"

        
        let api = APIRequest.getImage(path, size)
        let resultRequest = api.asRequest()
        XCTAssertNotNil(resultRequest, "Download Image Request should not be nil.")
        XCTAssertNotNil(resultRequest.url, "Download Image URL should not be nil.")
        XCTAssertEqual(resultRequest.url?.absoluteString, expectedURL, "Download Poster Image URL is matching the expected \(expectedURL)")
        
    }
    
    
    func test_imageAPI_backdropImage(){
        let path = "/9f5sIJEgvUpFv0ozfA6TurG4j22.jpg"
        let size = "w780"
        var expectedURL  = "\(imageEndPoint)"
        expectedURL += "/\(size)"
        expectedURL += "/\(path)"

        
        let api = APIRequest.getImage(path, size)
        let resultRequest = api.asRequest()
        XCTAssertNotNil(resultRequest, "Download Image Request should not be nil.")
        XCTAssertNotNil(resultRequest.url, "Download Image URL should not be nil.")
        XCTAssertEqual(resultRequest.url?.absoluteString, expectedURL, "Download Backdrop Image URL is matching the expected \(expectedURL)")
        
    }
}
