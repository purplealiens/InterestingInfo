//
//  InterestingInfoUITests.swift
//  InterestingInfoUITests
//
//  Created by O W Williams on 1/9/19.
//  Copyright © 2019 Onomaly LLC. All rights reserved.
//

import XCTest

class InterestingInfoUITests: XCTestCase {

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

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPhotoNodePressed() {
        
        let element = XCUIApplication().children(matching: .window).element(boundBy: 0).children(matching: .other).element
        element.tap()
        
        let element2 = element.children(matching: .other).element
        element2.children(matching: .other).element(boundBy: 1).otherElements["text"].children(matching: .other).matching(identifier: "Dexter H.").element(boundBy: 0).tap()
        element.tap()
        element2.children(matching: .other).element(boundBy: 3).otherElements["text"].children(matching: .other).matching(identifier: "Chetan R.").element(boundBy: 0).tap()
        element.tap()
        
    }
    
    func testTableOpenNodePressed() {
        
        let app = XCUIApplication()
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element
        element.tap()
        element.tap()
        
        let backButton = app.navigationBars["Staff"].buttons["Back"]
        backButton.tap()
        element.tap()
        
        let tablesQuery = app.tables
        let chetanRStaticText = tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Chetan R."]/*[[".cells.staticTexts[\"Chetan R.\"]",".staticTexts[\"Chetan R.\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        chetanRStaticText.tap()
        backButton.tap()
        element.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Dexter H."]/*[[".cells.staticTexts[\"Dexter H.\"]",".staticTexts[\"Dexter H.\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        backButton.tap()
        element.tap()
        chetanRStaticText.tap()
        backButton.tap()
 
        
    }

}
