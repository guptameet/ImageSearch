//
//  PictureViewerModelTests.swift
//  ImageSearchTests
//
//  Created by Meet on 2/10/19.
//  Copyright © 2019 Meet. All rights reserved.
//

import XCTest

class PictureViewerModelTests: XCTestCase {
    
    var viewModel : PictureViewerViewModel!
    
    
    override func setUp() {
        viewModel = PictureViewerViewModel()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchWithNoService() {
        viewModel.loadNextPage()
    }
    
    

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
