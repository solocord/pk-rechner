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
    var stock: Stock?
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Handle the text field's user input through delegate callbacks
        nameTextField.delegate = self
        
        // Set up views if editing an existing stock
        if let stock = stock {
            navigationItem.title = stock.name
            nameTextField.text = stock.name
            tickerTextField.text = stock.ticker
        }
        
        // Enable the save button only if the text field has a valid Stock name.
        updateSaveButtonState()
    }
    
    // MARK: - UITextFieldDelegate
    //
    // Text field should let go of First Responder status
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textFi