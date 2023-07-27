//
//  ServiceCalls.swift
//  Stocks
//
//  Created by Edgar Barocio on 7/26/23.
//

import Foundation

struct NetworkConstants {
    static let portfolioEndpoint = "https://storage.googleapis.com/cash-homework/cash-stocks-api/portfolio.json"
    static let malformedEndpoint = "https://storage.googleapis.com/cash-homework/cash-stocks-api/portfolio_malformed.json"
    static let emptyEndpoint = "https://storage.googleapis.com/cash-homework/cash-stocks-api/portfolio_empty.json"
}

class ServiceCalls {
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    typealias ServiceResult = (Data?, Error?) -> Void
    
    func fetchStockInfo(url: URL, completion: @escaping ServiceResult) {
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
