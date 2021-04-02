
//
//  Stock.swift
//  StockWatcher
//
//  Created by Philip Clapper on 2/3/17.
//
//

// MARK: Imports
import UIKit
import os.log

// MARK: - Class
class Stock: NSObject, NSCoding {
    
    // MARK: - Properties
    var name: String
    var ticker: String
    //var sma200: Float?
    //var sma100: Float?
    //var sma50: Float?
    //var exDividendDate: Float?
    //var dateAdded: Date
    
    // MARK: - Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("stocks")
    
    // MARK: - Types
    struct PropertyKey {