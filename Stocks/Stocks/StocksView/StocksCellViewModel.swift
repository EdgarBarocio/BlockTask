//
//  StocksCellViewModel.swift
//  Stocks
//
//  Created by Edgar Barocio on 7/26/23.
//

import Foundation

class StocksCellViewModel {
    var ticker: String
    var name: String
    var currency: String
    var price: Int
    var quantityOwned: Int
    var timeStamp: Int
    
    private var priceString: String?
    private var timeStampString: String?
    
    init(ticker: String, name: String, currency: String, price: Int, quantityOwned: Int, timeStamp: Int) {
        self.ticker = String(ticker)
        self.name = name
        self.currency = currency
        self.price = price
        self.quantityOwned = quantityOwned
        self.timeStamp = timeStamp
        
        updateValues()
    }
    
    private func updateValues() {
        self.timeStampString = self.timeStampToDate(self.timeStamp)
        self.priceString = self.priceToUSD(self.price)
    }
    
    private func priceToUSD(_ price: Int) -> String {
        
        return ""
    }
    
    private func timeStampToDate(_ timeStamp: Int) -> String {
        
        return ""
    }
}
