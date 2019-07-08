//
//  TheMovieIosTests.swift
//  TheMovieIosTests
//
//  Created by Medios Digitales on 7/6/19.
//  Copyright © 2019 Diego Fernando Cuesta. All rights reserved.
//

import XCTest
@testable import TheMovieIos

class TheMovieIosTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() {
        getMoviesSuccess()
        getCurrentMovieDetail()
        getCurrentMovieDetailNulleable()
        getSearchMoviesSuccessEmpty()
        getSearchMoviesSuccess()
    }
    
    func getMoviesSuccess() {
        let ex = expectation(description: "Success with movies ")
        let service = ListServicesManager.get

        service.requestPopularList(page: 1, success: { list in

            XCTAssertNotNil(list)
            ex.fulfill()
            
         }) { (error) in }
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail("error: \(error)")
            }
        }
    }
    
    func getSearchMoviesSuccessEmpty(){
        let ex = expectation(description: "Success with movies ")
        let service = ListServicesManager.get
        let query = "!@#¢∞"
        
        service.requestSearchQuery(query: query, success: { list in
            let listEmpty = list.count > 0 ? false : true
            XCTAssertTrue(listEmpty)
            ex.fulfill()
        }) { error in
            XCTFail("error: \(error)")
        }
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail("error: \(error)")
            }
        }
    }
    
    func getSearchMoviesSuccess(){
        let ex = expectation(description: "Success with movies ")
        let service = ListServicesManager.get
        let query = "rambo"
        
        service.requestSearchQuery(query: query, success: { list in
            XCTAssertNotNil(list)
            ex.fulfill()
        }) { error in
            XCTFail("error: \(error)")
        }
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail("error: \(error)")
            }
        }
    }
    
    func getCurrentMovieDetail(){
        let dtInteractor = DetailMovieInteractor()
        let id: Int = 447332
        
        let movie = dtInteractor.getCurrentMovieDetail(id)
        XCTAssertNotNil(movie)
    }
    
    func getCurrentMovieDetailNulleable(){
        let dtInteractor = DetailMovieInteractor()
        let id: Int = 0
        
        let movie = dtInteractor.getCurrentMovieDetail(id)
        XCTAssertNil(movie)
    }

}
