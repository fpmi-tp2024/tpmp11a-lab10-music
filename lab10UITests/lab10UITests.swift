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
        let segmentedControl = app.segmentedControls["signInOrUp"]
        XCTAssert(segmentedControl.exists)
        let regButton = segmentedControl.buttons.element(boundBy: 0)
        XCTAssert(regButton.exists)
        regButton.tap()
        let loginInput = app.textFields["loginInput"]
        XCTAssert(loginInput.exists)
        loginInput.tap()
        loginInput.typeText("1")
        let passwordInput = app.secureTextFields["passwordInput"]
        XCTAssert(passwordInput.exists)
        passwordInput.tap()
        passwordInput.typeText("1")
        let emailInput = app.textFields["emailInput"]
        XCTAssert(emailInput.exists)
        emailInput.tap()
        emailInput.typeText("1")
    }
}
