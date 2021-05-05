//
//  StocksViewController.swift
//  StockWatcher
//
//  Created by Philip Clapper on 2/3/17.
//
//

// MARK: Imports
import UIKit
import os.log

// MARK: - Class
class StocksViewsController: UIViewController, UITextFieldDelegate {

    // MARK: - Properties
    @IBOutlet weak var tickerTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    // This value is either passed by `StockTableViewController` in `prepare(for:sender:)`
    // or constructed as part of adding a new stock.
    