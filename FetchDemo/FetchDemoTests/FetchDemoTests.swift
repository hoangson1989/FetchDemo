//
//  FetchDemoTests.swift
//  FetchDemoTests
//
//  Created by Sonny Truong on 6/8/24.
//

import XCTest
import Combine
@testable import FetchDemo // Import your app module here

final class FetchDemoTests: XCTestCase {
    var mealAPIService: MealService!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mealAPIService = MealService.shared
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mealAPIService = nil
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    
    func testFetchDessertsSuccess() throws {
        let expectation = XCTestExpectation(description: "Desserts fetched successfully")
        
        let cancellable = mealAPIService.fetchDesserts()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    // Fulfill the expectation
                    expectation.fulfill()
                case .failure(let error):
                    // Fail the test
                    XCTFail("Error fetching desserts: \(error.localizedDescription)")
                }
            }, receiveValue: { _ in })
        
        wait(for: [expectation], timeout: 5.0)
        
        cancellable.cancel()
    }
    
    func testFetchMealDetailSuccess() throws {
        let expectation = XCTestExpectation(description: "Meal detail fetched successfully")
        
        let cancellable = mealAPIService.fetchMealDetail(id: "53049")
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    // Fulfill the expectation
                    expectation.fulfill()
                case .failure(let error):
                    // Fail the test
                    XCTFail("Error fetching meal detail: \(error.localizedDescription)")
                }
            }, receiveValue: { _ in })
        
        wait(for: [expectation], timeout: 5.0)
        
        cancellable.cancel()
    }
}
