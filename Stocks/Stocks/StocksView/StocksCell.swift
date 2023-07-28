//
//  StocksCell.swift
//  Stocks
//
//  Created by Edgar Barocio on 7/26/23.
//

import Foundation
import UIKit

/// Class for the Stocks Cell
class StocksCell: UITableViewCell {
    
    static let identifier = "stocksCell"
    
    /**
    Function that updates the table view cell with the selected stock info
     
     - Parameters:
        - viewModel: The StocksCellViewModel containing all the info to display.
     */
    func configure(_ viewModel: StocksCellViewModel) {
        self.textLabel?.text = "Name: " + viewModel.name + "\nTicker: " + viewModel.ticker
        self.detailTextLabel?.text = "Currency: " + viewModel.currency + "\n"
        + "Price: " + viewModel.priceString + "\n"
        + "Owned: \(viewModel.quantityOwned)" + "\n"
        + "Time Stamp: " + viewModel.timeStampString
    }
}
