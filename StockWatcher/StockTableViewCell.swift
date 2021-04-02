//
//  StockTableViewCell.swift
//  StockWatcher
//
//  Created by Philip Clapper on 2/7/17.
//
//

import UIKit

class StockTableViewCell: UITableViewCell {

    // MARK: - Properties
    @IBOutlet weak var tickerLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool,