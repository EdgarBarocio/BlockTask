//
//  MockServiceCalls.swift
//  StocksTests
//
//  Created by Edgar Barocio on 7/27/23.
//

import Foundation

class MockServiceCalls {
    typealias ServiceResult = (Data?, Error?) -> Void
    
    func fetchStockInfo(url: URL, completion: @escaping ServiceResult) {
        DispatchQueue.main.async {
            //completion(data, nil)
        }
    }

    func fetchEmptyInfo(url: URL, completion: @escaping ServiceResult) {
        DispatchQueue.main.async {
            //completion(data, nil)
        }
    }
    
    func fetchMalformedInfo(url: URL, completion: @escaping ServiceResult) {
        DispatchQueue.main.async {
            //completion(data, nil)
        }
    }
    
    func fetchError(url: URL, completion: @escaping ServiceResult) {
        DispatchQueue.main.async {
            //completion(nil, error)
        }
    }
}
