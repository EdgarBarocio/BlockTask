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
    
    var priceString: String?
    var timeStampString: String?
    
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
        let myDouble = Double(price) / Double(100)
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        let priceString = currencyFormatter.string(from: NSNumber(value: myDouble))
        return priceString ?? ""
    }
    
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
