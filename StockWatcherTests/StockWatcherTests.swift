//
//  StockWatcherTests.swift
//  StockWatcherTests
//
//  Created by Philip Clapper on 1/31/17.
//
//

import XCTest
@testable import StockWatcher

class StockWatcherTests: XCTestCase {
    
    // MARK: - StockWatcher Class Tests
    
    // Confirm that the Stock initializer returns a Stock object when passed valid parameters
    func testStockInitializationSucceeds() {
        // Name and ticker are produced
        let nameExists = Stock.init(name: "AT&T", ticker: "T")
        XCTAssertNotNil(nameExists)
        
        // Confirm that the Stock initializer should fail if name or ticker is not passed in
        let nullName = Stock.init(name: "", ticker: "T")
        XCTAssertNil(nullName)
        
        let nullTicker = Stock.init(name: "AT&T", ticker: "")
        XCTAssertNil(nullTicker)
    }
    
//    override func setUp() {
//        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test me