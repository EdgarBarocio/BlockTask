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
            completion(data, nil)
        }
    }

    func fetchEmptyInfo(url: URL, completion: @escaping ServiceResult) {
        dataTask?.cancel()
        
        dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            
            defer {
                self.dataTask = nil
            }
            
            if let error = error {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            } else if
                let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                
                DispatchQueue.main.async {
                    completion(data, nil)
                }
            }
            
        }
        
        dataTask?.resume()
    }
    
    func fetchMalformedInfo(url: URL, completion: @escaping ServiceResult) {
        dataTask?.cancel()
        
        dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            
            defer {
                self.dataTask = nil
            }
            
            if let error = error {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            } else if
                let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                
                DispatchQueue.main.async {
                    completion(data, nil)
                }
            }
            
        }
        
        dataTask?.resume()
    }


}
