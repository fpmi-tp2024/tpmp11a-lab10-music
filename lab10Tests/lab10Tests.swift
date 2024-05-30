//
//  lab10Tests.swift
//  lab10Tests
//
//  Created by Alexey on 27.05.2024
//


import XCTest
@testable import lab10

class lab10Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testShowInfolWindowSetupView() {
        let testShowInfolWindow = ShowInfolWindow()
        let testUIView = UIView()
        testShowInfolWindow.short(testUIView, txt_msg: "Hello, world!")
        XCTAssertEqual(testUIView.subviews.count, 2)
    }
    
    func testShowInfolWindowSetupMSG() {
        let testShowInfolWindow = ShowInfolWindow()
        let testUIView = UIView()
        testShowInfolWindow.short(testUIView, txt_msg: "Hello, world!")
        let firView = testUIView.subviews[1] as UIView
        let labelT = firView.subviews[0] as! UILabel
        XCTAssertEqual(labelT.text, "Hello, world!")
    }
    
    func testShowInfolWindowSetupMSGCenter() {
        let testShowInfolWindow = ShowInfolWindow()
        let testUIView = UIView()
        testShowInfolWindow.short(testUIView, txt_msg: "Hello, world!")
        let firView = testUIView.subviews[1] as UIView
        let labelT = firView.subviews[0] as! UILabel
        XCTAssertEqual(labelT.center.x, firView.bounds.width / 2)
        XCTAssertEqual(labelT.center.y, firView.bounds.height / 2)
    }
    
    func testMainViewControllerSetupData() {
        let vc = MainViewController()
        let testData = vc.setupData()
        let path = Bundle.main.path(forResource: "Questions", ofType: "plist")
        let dict = NSDictionary(contentsOfFile: path!)
        XCTAssertEqual(testData, dict!.object(forKey: "Questions") as! [String])
    }
}
