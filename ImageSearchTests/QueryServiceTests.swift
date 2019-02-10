//
//  QueryServiceTests.swift
//  ImageSearchTests
//
//  Created by Meet on 2/10/19.
//  Copyright © 2019 Meet. All rights reserved.
//

import XCTest

class QueryServiceTests: XCTestCase {
    
    var queryService : QueryService!
    let query = "kitten"
    let page = 1
    var sampleQueryURL : String!

    override func setUp() {
        queryService = QueryService()
        sampleQueryURL = String(format: "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=3e7cc266ae2b0e0d78e279ce8e361736&format=json&nojsoncallback=1&safe_search=1&text=%@&page=%d", query, page)
    }

    override func tearDown() {
        queryService = nil
        sampleQueryURL = nil
    }

    func testNthURL() {
        if let url = queryService.getSearchURL(withQuery: query, andPage: page)?.url?.absoluteString {
            XCTAssertEqual(url, sampleQueryURL, "Success")
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
