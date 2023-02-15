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
        let nameExists = Stock.init(name: 