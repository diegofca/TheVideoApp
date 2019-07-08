//
//  TheMovieIosUITests2.swift
//  TheMovieIosUITests2
//
//  Created by Medios Digitales on 7/8/19.
//  Copyright © 2019 Diego Fernando Cuesta. All rights reserved.
//

import XCTest

class TheMovieIosUITests2: XCTestCase {

    let app = XCUIApplication()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample(){
        clickCollectionMovies()
    }
    
    func clickCollectionMovies() {
        app.launch()
        app.collectionViews.cells.element(boundBy:0).tap()
    }

}
