//
//  DynamicSkyUITests.swift
//  DynamicSkyUITests
//
//  Created by dereq on 4/20/22.
//

import XCTest

class DynamicSkyUITests: XCTestCase {

    func testZipCodeSearchUI() throws {
        let app = XCUIApplication()
        app.launch()
        app.tabBars["Tab Bar"].buttons["Search"].tap()
        app.textFields["Enter a Zip Code"].tap()
        app.textFields["Enter a Zip Code"].typeText("44720")
        app.images["Search"].tap()

        let localityName = app.textFields["North Canton"]

        if localityName.waitForExistence(timeout: 5) {
            XCTAssert(localityName.exists)
        }
    }

}
