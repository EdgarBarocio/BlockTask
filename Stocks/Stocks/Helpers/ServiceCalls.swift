//
//  ServiceCalls.swift
//  Stocks
//
//  Created by Edgar Barocio on 7/26/23.
//

import Foundation

/// Constants for the endpoints provided for the stocks task, to point to each one, the app has to be re-built.
struct NetworkConstants {
    static let portfolioEndpoint = "https://storage.googleapis.com/cash-homework/cash-stocks-api/portfolio.json"
    static let malformedEndpoint = "https://storage.googleapis.com/cash-homework/cash-stocks-api/portfolio_malformed.json"
    static let emptyEndpoint = "https://storage.googleapis.com/cash-homework/cash-stocks-api/portfolio_empty.json"
}

/// Protocol with the signature for the base service call. Used this to allow for dependency injection
protocol ServiceProtocol {
    func fetchStockInfo(url: URL, completion: @escaping (Data?, Error?) -> Void)
}

/// ServiceCalls class, conforms to ServiceProtocol and implements fetchStockInfo(url: completion: )
class ServiceCalls: ServiceProtocol {
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    typealias ServiceResult = (Data?, Error?) -> Void
    
    /**
    Function that uses URL session to fetch Stock information
     
     - Parameters:
        - url: Data representing the service response
        - completion: Closure that passes the resulting data, object response and error
     */
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
