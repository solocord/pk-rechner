
//
//  StockTableViewController.swift
//  StockWatcher
//
//  Created by Philip Clapper on 2/7/17.
//
//

import UIKit
import os.log

class StockTableViewController: UITableViewController {
    
    // MARK: - Properties
    var stocks = [Stock]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller
        navigationItem.leftBarButtonItem = editButtonItem
        
        // Load any saved stocks, otherwise load sample data
        if let savedStocks = loadStocks() {
            stocks += savedStocks
        } else {
            // Load the sample data
            loadSampleStocks()
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return stocks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be queued using a cell identifier
        // This is using the controller for the StockTableViewCell
        let cellIdentifier = "StockTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? StockTableViewCell else {
            fatalError("The dequeued cell is not an instance of StockTableViewCell.")
        }
        
        // Fetches the appropriate stock for the data source layout
        let stock = stocks[indexPath.row]

        // Configure the cell...
        cell.nameLabel.text = stock.name
        cell.tickerLabel.text = stock.ticker
        
        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            stocks.remove(at: indexPath.row)
            saveStocks()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
            case "AddItem":
                os_log("Adding a new stock.", log: OSLog.default, type: .debug)
            
            case "ShowDetail":
                guard let stockDetailViewController = segue.destination as? StocksViewsController
                    else {
                        fatalError("Unexpected destination: \(segue.destination)")
                }
            
                guard let selectedStockCell = sender as? StockTableViewCell else {
                    fatalError("Unexpected sender: \(sender)")
                }
            
                guard let indexPath = tableView.indexPath(for: selectedStockCell) else {
                    fatalError("The selected cell is not being displayed by the table")
                }
            
                let selectedStock = stocks[indexPath.row]
                stockDetailViewController.stock = selectedStock
            
            default:
                fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
    
    // MARK: - Actions
    
    @IBAction func unwindToStockList(sender: UIStoryboardSegue) {
        // Incoming sender from StocksViewController
        if let sourceViewController = sender.source as? StocksViewsController, let stock = sourceViewController.stock {
                
            // Was a row in the table selected?
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing stock
                stocks[selectedIndexPath.row] = stock
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                // User didn't tap the table. Therefore, add a new stock
                let newIndexPath = IndexPath(row: stocks.count, section: 0)
            
                stocks.append(stock)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
            // Save the stocks.
            saveStocks()
        }
    }
    
    // MARK: - Private Methods
    
    private func loadSampleStocks() {
        
        // Create test data
        guard let stock1 = Stock(name: "AT&T", ticker: "T") else {
            fatalError("Unable to instantiate stock1")
        }
        
        guard let stock2 = Stock(name: "Verizon", ticker: "VZ") else {
            fatalError("Unable to instantiate stock2")
        }
        
        guard let stock3 = Stock(name: "Apple", ticker: "AAPL") else {
            fatalError("Unable to instantiate stock3")
        }
        
        // Add above test data to the Stocks[] array
        stocks += [stock1, stock2, stock3]
    }
    
    private func saveStocks() {
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(stocks, toFile: Stock.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("Stocks successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save stocks...", log: OSLog.default, type: .debug)
        }
    }
    
    private func loadStocks() -> [Stock]? {
        
        return NSKeyedUnarchiver.unarchiveObject(withFile: Stock.ArchiveURL.path) as? [Stock]
    }
}