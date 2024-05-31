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
        loginInput.typeText("5")
        let passwordInput = app.secureTextFields["passwordInput"]
        XCTAssert(passwordInput.exists)
        passwordInput.tap()
        passwordInput.typeText("5")
        let emailInput = app.textFields["emailInput"]
        XCTAssert(emailInput.exists)
        emailInput.tap()
        emailInput.typeText("5")
        let screen = app.windows.element(boundBy: 0)
        let coordinate = screen.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)) // Центр экрана
        coordinate.tap()
        app.children(matching: .window).element(boundBy: 0).tap()
        let phoneInput = app.textFields["phoneInput"]
        XCTAssert(phoneInput.exists)
        phoneInput.tap()
        phoneInput.typeText("5")
        coordinate.tap()
        app.children(matching: .window).element(boundBy: 0).tap()
        let enterButton2 = app.buttons["ОК"]
        XCTAssert(enterButton2.exists)
        enterButton2.tap()
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
