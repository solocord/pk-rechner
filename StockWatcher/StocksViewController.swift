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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the save button while editing.
        saveButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        updateSaveButtonState()
        navigationItem.title = nameTextField.text
    }
    
    // MARK: - Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view
        // controller needs to be dismissed in two different ways.
        
        // Is the view controller presenting the scene of type UINavigationController?
        let isPresentingInAddStockMode = presentingViewController is UINavigationController
        
        // If true (user tapped Add, which is embedded in its own navigation controller
        if isPresentingInAddStockMode {
            dismiss(animated: true, completion: nil)
            
            // Otherwise, user is editing existing item, as stock detail was pushed
            // onto the navigation stack on tapping stock item
        } else if let owningNavigationController = navigationController{
            
            // Pop view controller off the navigation stack, returning user to stock list
            owningNavigationController.popViewController(animated: true)
        } else {
            fatalError("The StockViewController is not inside a navigation controller.")
        }
    }

    
    // This method lets you configure a view controller before it's presented
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is tapped.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = nameTextField.text ?? ""
        let ticker = tickerTextField.text ?? ""
        
        // Set the stock to be passed to StockTableViewController after the unwind segue
        stock = Stock(name: name, ticker: ticker)
    }
    
    // MARK: - Actions
    //@IBAction func setDefaultLabelText(_ sender: UIButton) {
    //    mealNameLabel.text = "Default Text"
    //}
    
    // MARK: - Private Metho