//
//  bldTests.swift
//  bldTests
//
//  Created by John Sarracino on 12/3/16.
//  Copyright © 2016 Eric Fakhourian. All rights reserved.
//

import XCTest
@testable import bld

class bldTests: XCTestCase {
    
    // TODO: build pantry in here
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // TODO: pass pantry ingredients here, add assert statement on output
        print(bld.getRecipeJSONs())
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
