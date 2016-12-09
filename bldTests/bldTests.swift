//
//  bldTests.swift
//  bldTests
//
//  Created by John Sarracino on 12/3/16.
//  Copyright © 2016 Eric Fakhourian. All rights reserved.
//

import XCTest
@testable import bld

let testPantry = bld.Pantry()
let diet = bld.Diet()
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
    
//    func testExample() {
//        // TODO: pass pantry ingredients here, add assert statement on output
//        print(bld.getRecipeJSONs())
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
    
    func testGetRecipes() {
//        let recipes = bld.getCandidateRecipes(mrday: bld.MRDay.breakfast, diet: bld.Diet())
//        print(recipes)
    }
    
    func testPlanning() {
        // mealrequest, pantry, diet
//        self.testPantry
        let day1 = bld.DayRequest(date: "Monday", breakfast: true, lunch: true, dinner: true)
        let day2 = bld.DayRequest(date: "Wednesday", breakfast: false, lunch: true, dinner: false)
//        let days = [day1, day2]
        let days = [day2]
        let mealReq = bld.MealRequest(request: days, budget: 10.0)
        let plan = bld.generatePlan(mr: mealReq, pan: testPantry, diet: diet)
        print(plan)
    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
