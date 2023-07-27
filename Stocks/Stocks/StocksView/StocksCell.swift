//
//  StocksCell.swift
//  Stocks
//
//  Created by Edgar Barocio on 7/26/23.
//

import Foundation
import UIKit

class StocksCell: UITableViewCell {
    
    @IBOutlet weak var tickerLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
    static let identifier = "stocksCell"
    
    func configure(_ viewModel: StocksCellViewModel) {
        self.tickerLabel?.text = "Ticker: \(viewModel.ticker)"
        self.nameLabel?.text = "Name: " + viewModel.name
        self.currencyLabel?.text = "Currency: " + viewModel.currency
        self.priceLabel?.text = "Price: \(viewModel.price)"
        self.quantityLabel?.text = "Owned: \(viewModel.quantityOwned)"
        self.timestampLabel?.text = "Time Stamp: \(viewModel.timeStamp)"
    }
}
