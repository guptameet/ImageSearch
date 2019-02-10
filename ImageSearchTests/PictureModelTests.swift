//
//  PictureModelTests.swift
//  ImageSearchTests
//
//  Created by Meet on 2/10/19.
//  Copyright © 2019 Meet. All rights reserved.
//

import XCTest

class PictureModelTests: XCTestCase {
    var pic : Picture!
    override func setUp() {
        pic = Picture(withTitle: "title", ServerName: "server", Identifier: "id", FarmIdentifier: 0, andSecret: "secret")
    }

    override func tearDown() {
        self.pic = nil
    }

    func testPictureURL() {
        XCTAssertEqual(pic.imageURL, "https://farm0.static.flickr.com/server/id_secret.jpg","Success")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
