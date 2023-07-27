//
//  JSONSerializer.swift
//  Stocks
//
//  Created by Edgar Barocio on 7/26/23.
//

import Foundation

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
