//
//  StocksCellViewModel.swift
//  Stocks
//
//  Created by Edgar Barocio on 7/26/23.
//

import Foundation

/// Class for The StocksCellViewModel, aditional formatting is done here
class StocksCellViewModel {
    var ticker: String
    var name: String
    var currency: String
    var price: Int
    var quantityOwned: Int
    var timeStamp: Int
    
    var priceString: String = ""
    var timeStampString: String = ""
    
    init(ticker: String, name: String, currency: String, price: Int, quantityOwned: Int, timeStamp: Int) {
        self.ticker = String(ticker)
        self.name = name
        self.currency = currency
        self.price = price
        self.quantityOwned = quantityOwned
        self.timeStamp = timeStamp
        
        updateValues()
    }
    
    /**
    Private function that updates the values of timeStamp and price form Ints to readable info
     */
    private func updateValues() {
        self.timeStampString = self.timeStampToDate(self.timeStamp)
        self.priceString = self.priceToUSD(self.price)
    }
    
    /**
    Function that updates the table view cell with the selected stock info
     
     - Parameters:
        - price: Integer representing the price of the stock in cents
     - Returns:
        - String: Formated price in USD
     */
    private func priceToUSD(_ price: Int) -> String {
        let myDouble = Double(price) / Double(100)
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        let priceString = currencyFormatter.string(from: NSNumber(value: myDouble))
        return priceString ?? ""
    }
    
    /**
    Function that takes the stock timestamp and converts it to a readable date string
     
     - Parameters:
        - timeStamp: Integer representing UNIX time
     - Returns:
        - String: A formatted Date.
     */
    private func timeStampToDate(_ timeStamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timeStamp))
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
}
