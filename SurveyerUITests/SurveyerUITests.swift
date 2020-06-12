//
//  SurveyerUITests.swift
//  SurveyerUITests
//
//  Created by Pisit W on 10/6/2563 BE.
//  Copyright © 2563 blyscuit. All rights reserved.
//

import XCTest

class SurveyerUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testHomeView() throws {
        let app = XCUIApplication()
        app.launch()
        
        let exists = app.collectionViews.cells.element.waitForExistence(timeout: 10.0)
        XCTAssertTrue(exists,"no cell appear")

        app.collectionViews.cells.element(boundBy:0).tap()
        
        app.otherElements["home.mainButton"].tap()
        
        let detail = app.staticTexts.element.exists
        XCTAssertTrue(detail,"no text appear")
    }
    
    func testHomeViewRefresh() throws {
        let app = XCUIApplication()
        app.launch()
        
        let exists = app.collectionViews.cells.element.waitForExistence(timeout: 15.0)
        XCTAssertTrue(exists,"no cell appear")
        
        let cellCount = app.pageIndicators.element.numberOfPages() ?? 0
        
        app.swipeUp()
        
        XCTAssertTrue(app.pageIndicators.element.currentPage() == 1)
        
        for i in 0..<8 {
            app.swipeUp()
        }
        
        let exp = expectation(description: "Test load more")
        let result = XCTWaiter.wait(for: [exp], timeout: 10.0)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertTrue((app.pageIndicators.element.numberOfPages() ?? 0) > cellCount)
        } else {
            XCTFail("Delay interrupted")
        }
        
        XCUIApplication().navigationBars.children(matching: .button).allElementsBoundByIndex[0].tap()
        
        
        let exp2 = expectation(description: "Test refresh all")
        let result2 = XCTWaiter.wait(for: [exp2], timeout: 10.0)
        if result2 == XCTWaiter.Result.timedOut {
            XCTAssertTrue((app.pageIndicators.element.numberOfPages() ?? 0) == cellCount)
        } else {
            XCTFail("Delay interrupted")
        }
        
    }
}

//https://stackoverflow.com/a/52606058/3736373
extension XCUIElement {

    func currentPageAndNumberOfPages() -> (Int, Int)? {
        guard elementType == .pageIndicator, let pageIndicatorValue = value as? String else {
            return nil
        }
        // Extract two numbers. This should be language agnostic.
        // Examples: en:"3 of 5", ja:"全15ページ中10ページ目", es:"4 de 10", etc
        let regex = try! NSRegularExpression(pattern: "^\\D*(\\d+)\\D+(\\d+)\\D*$", options: [])
        let matches = regex.matches(in: pageIndicatorValue, options: [], range: NSRange(location: 0, length: pageIndicatorValue.count))
        if matches.isEmpty {
            return nil
        }
        let group1 = matches[0].range(at: 1)
        let group2 = matches[0].range(at: 2)
        let numberString1 = pageIndicatorValue[Range(group1, in: pageIndicatorValue)!]
        let numberString2 = pageIndicatorValue[Range(group2, in: pageIndicatorValue)!]
        let number1 = Int(numberString1) ?? 0
        let number2 = Int(numberString2) ?? 0
        let numberOfPages = max(number1, number2)
        var currentPage = min(number1, number2)
        // Make it 0 based index
        currentPage = currentPage > 0 ? (currentPage - 1) : currentPage
        return (currentPage, numberOfPages)
    }

    /// return current page index (0 based) of an UIPageControl referred by XCUIElement
    func currentPage() -> Int? {
        return currentPageAndNumberOfPages()?.0 ?? nil
    }

    /// return number of pages of an UIPageControl referred by XCUIElement
    func numberOfPages() -> Int? {
        return currentPageAndNumberOfPages()?.1 ?? nil
    }
}
