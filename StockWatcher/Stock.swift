
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
        static let name = "name"
        static let ticker = "ticker"
    }
    
    // MARK: - Initialization
    init?(name: String, ticker: String) {
        
        // Name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        // Ticker must not be empty
        guard !ticker.isEmpty else {
            return nil
        }
        
        // Initialize stored properties
        self.name = name
        self.ticker = ticker
        //self.sma200 = sma200
        //self.sma100 = sma100
        //self.sma50 = sma50
        //self.exDividendDate = exDividendDate
        //self.dateAdded = dateAdded
    }
    
    // MARK: - NSCoding
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(ticker, forKey: PropertyKey.ticker)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // The name is required. If we cannot decode a name string, the initializer
        // should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String
            else {
                os_log("Unable to decode the name for a Stock object.", log: OSLog.default, type: .debug)
                
                return nil
        }
        
        guard let ticker = aDecoder.decodeObject(forKey: PropertyKey.ticker) as? String
            else {
                os_log("Unable to decode a ticker for a Stock object.", log: OSLog.default, type: .debug)
                
                return nil
        }
        
        // Must call designated initializer.
        self.init(name: name, ticker: ticker)
    }
}