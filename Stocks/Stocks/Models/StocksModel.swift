//
//  StocksModel.swift
//  Stocks
//
//  Created by Edgar Barocio on 7/26/23.
//

import Foundation

struct StocksModel: Codable {
    struct Stocks: Codable {
        var ticker: String?
        var name: String?
        var currency: String?
        var currentPrice: Int?
        var quantity: Int?
        var timeStamp: Int?
        
        enum CodingKeys: String, CodingKey {
            case ticker
            case name
            case currency
            case currentPrice = "current_price_cents"
            case quantity
            case timeStamp = "current_price_timestamp"
        }
    }
    
    var stocks: [Stocks]
}
