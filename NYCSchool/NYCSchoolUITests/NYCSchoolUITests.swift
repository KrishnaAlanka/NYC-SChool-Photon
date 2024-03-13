//
//  NYCSchoolUITests.swift
//  NYCSchoolUITests
//
//  Created by Krishna on 3/13/24.
//

import XCTest

final class SchoolsListViewTest: XCTestCase {
    
    var app : XCUIApplication!

    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testSchoolsListDisplay(){
        
        XCTAssertTrue(app.navigationBars["Schools List"].exists)
        
        XCTAssertTrue(app.progressIndicators["Loading.."].exists)
        
        let schoolList = app.tables.firstMatch
        XCTAssertTrue(schoolList.waitForExistence(timeout: 10))
        
        XCTAssertTrue(schoolList.cells.count > 0)
        
    }
    
    func testSchoolCellTap(){
        
        XCTAssertTrue(app.navigationBars["Schools List"].exists)
        
        //list load
        let schoolList = app.tables.firstMatch
        XCTAssertTrue(schoolList.waitForExistence(timeout: 10))
        
        //tap on first cell
        let firstSchoolCell = schoolList.cells.element(boundBy: 0)
        XCTAssertTrue(firstSchoolCell.waitForExistence(timeout: 5))
        firstSchoolCell.tap()
        
        XCTAssertTrue(app.navigationBars["School details"].exists)
        
    }
    
    

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
