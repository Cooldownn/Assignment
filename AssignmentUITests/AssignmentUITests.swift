//
//  AssignmentUITests.swift
//  AssignmentUITests
//
//  Created by Cooldown on 21/8/18.
//  Copyright © 2018 Cooldown. All rights reserved.
//

import XCTest

class AssignmentUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let app = XCUIApplication()
        app.buttons["Add"].tap()
        //let timePicker : XCUIElement = app.datePickers["timePicker"];
        //app.datePickers["]
        app.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "11")
        app.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "59")
        app.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: "PM")
        app.buttons["Repeat"].tap()
        app.tables["weeksdayTable"].staticTexts["Every Monday"].tap()
        app.buttons["Done"].tap()
        app.buttons["Alarm Method"].tap()
        app.tables["tableViewMethod"].cells.element(boundBy: 0).tap()
        let cell = app.tables["alarmPICtv"].cells
        cell.element(boundBy: 0).tap()
        app.buttons["Save"].tap()
        app.tables["tableViewMethod"].cells.element(boundBy: 0).tap()
        cell.element(boundBy: cell.count-1).tap()
        addUIInterruptionMonitor(withDescription: "Notification Permissions") { (alert) -> Bool in
            let button = alert.buttons["actionPhoto"]
            if button.exists {
                button.tap()
                return true
            }
            return false
        }
        app.tap()
        app.buttons["Back"].tap()
        app.buttons["Back"].tap()
        app.buttons["Save"].tap()
        let cell1 = app.tables["VCC"].cells
        cell1.element(boundBy: cell1.count-1).swipeLeft()
        cell1.element(boundBy: cell1.count-1).buttons["Delete"].tap()
        
    }
    
}
