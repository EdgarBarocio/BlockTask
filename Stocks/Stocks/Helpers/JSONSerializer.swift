//
//  JSONSerializer.swift
//  Stocks
//
//  Created by Edgar Barocio on 7/26/23.
//

import Foundation

/**
Function that reads the service response, serializes it usion JSONDecoder and creates an array of StockModel.Stocks
 
 - Parameters:
    - response: Data representing the service response
 - Returns: Optional StocksModel array.
 */
class JSONSerializer {
    func serializeResponse(response: Data) -> [StocksModel.Stocks]? {
        
        let decoder = JSONDecoder()
        
        do {
            let decoded = try decoder.decode(StocksModel.self, from: response)
            return decoded.stocks
        } catch {
            print(error)
            print(error.localizedDescription)
            return nil
        }
    }
}
