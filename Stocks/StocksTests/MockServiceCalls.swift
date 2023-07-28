//
//  MockServiceCalls.swift
//  StocksTests
//
//  Created by Edgar Barocio on 7/27/23.
//

import Foundation
@testable import Stocks

enum MockServiceError : Error {
    
    case invalidResponse
}

class MockServiceCalls: ServiceProtocol {
    
    typealias ServiceResult = (Data?, Error?) -> Void
    
    var data: Data?
    var error: Error?
    
    func fetchStockInfo(url: URL, completion: @escaping ServiceResult) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            completion(self.data, self.error)
        }
    }
}
