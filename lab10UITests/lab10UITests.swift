//
//  lab10UITests.swift
//  lab10UITests
//
//  Created by test on 30.05.24.
//  Copyright © 2024 DM. All rights reserved.
//

import XCTest

final class lab10UITests: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()
        let enterButton = app.buttons["Вход"]
        XCTAssert(enterButton.exists)
        enterButton.tap()
        let loginInput = app.textFields["loginInput"]
        XCTAssert(loginInput.exists)
        loginInput.typeText("1")
        let passwordInput = app.textFields["passwordInput"]
        XCTAssert(passwordInput.exists)
        passwordInput.typeText("1")
        let coursesBtn = app.buttons["Courses"]
        XCTAssert(coursesBtn.exists)
        coursesBtn.tap()
        XCTAssert(app.buttons["Calmar"].exists)
        XCTAssert(app.buttons["MusicEvenings"].exists)
        XCTAssert(app.buttons["OrchestraPlaying"].exists)
        XCTAssert(app.buttons["Drums"].exists)
        XCTAssert(app.buttons["BuyInstruments"].exists)
    }
}
