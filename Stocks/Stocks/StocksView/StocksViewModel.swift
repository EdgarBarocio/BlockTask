//
//  StocksViewModel.swift
//  Stocks
//
//  Created by Edgar Barocio on 7/26/23.
//

import Foundation

class StocksViewModel {
    private var services: ServiceCalls
    var showLoading: (() -> Void)?
    var dismissLoading: (() -> Void)?
    var showGenericError: ((String) -> Void)?
    var didGetSearchResults: (([StocksModel.Stocks]) -> Void)?
    
    init(services: ServiceCalls) {
        self.services = services
    }
    
    func fetchStockInfo() {
        guard let url = URL(string: NetworkConstants.portfolioEndpoint) else {
            self.showGenericError?("URL Error, please try again")
            return
        }
        
        self.showLoading?()
        services.fetchBookSearch(url: url) { [weak self] data, error  in
            guard let self = self else { return }
            self.dismissLoading?()
            if let data = data {
                self.parseResults(resultsData: data)
            }
            
            if let error = error {
                self.showGenericError?(error.localizedDescription)
            }
        }
    }
    
    func fetchMalformedService() {
        guard let url = URL(string: NetworkConstants.malformedEndpoint) else {
            self.showGenericError?("URL Error, please try again")
            return
        }
        
        self.showLoading?()
        services.fetchBookSearch(url: url) { [weak self] data, error  in
            guard let self = self else { return }
            self.dismissLoading?()
            if let data = data {
                self.parseResults(resultsData: data)
            }
            
            if let error = error {
                self.showGenericError?(error.localizedDescription)
            }
        }
    }
    
    func fetchEmptyService() {
        guard let url = URL(string: NetworkConstants.emptyEndpoint) else {
            self.showGenericError?("URL Error, please try again")
            return
        }
        
        self.showLoading?()
        services.fetchBookSearch(url: url) { [weak self] data, error  in
            guard let self = self else { return }
            self.dismissLoading?()
            if let data = data {
                self.parseResults(resultsData: data)
            }
            
            if let error = error {
                self.showGenericError?(error.localizedDescription)
            }
        }
    }
    
    func returnFailedSearch(errorString: String) {
        self.showGenericError?(errorString)
    }
    
    func parseResults(resultsData: Data) {
        let serializer = JSONSerializer()
        
        if let result = serializer.serializeResponse(response: resultsData) {
            self.didGetSearchResults?(result)
        } else {
            self.returnFailedSearch(errorString: "No results found")
        }
    }
}
