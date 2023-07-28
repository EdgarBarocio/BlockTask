//
//  StocksViewModel.swift
//  Stocks
//
//  Created by Edgar Barocio on 7/26/23.
//

import Foundation

class StocksViewModel {
    private var services: ServiceProtocol
    
    /// closured used as callbacks of the view controller
    var showLoading: (() -> Void)?
    var dismissLoading: (() -> Void)?
    var showGenericError: ((String) -> Void)?
    var didGetSearchResults: (([StocksModel.Stocks]) -> Void)?
    
    /// Initializer that takes the ServiceProtocol implementation as a dependenci injection
    init(services: ServiceProtocol = ServiceCalls()) {
        self.services = services
    }
    
    /**
    Private function that uses the services to get the Stocks information. Uses the fetched info to decide if it calls the
     error message generator or the json serializer for data formatting.
     */
    func fetchStockInfo() {
        guard let url = URL(string: NetworkConstants.portfolioEndpoint) else {
            self.showGenericError?("URL Error, please try again")
            return
        }
        
        self.showLoading?()
        services.fetchStockInfo(url: url) { [weak self] data, error  in
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
    
    /**
    Private function that calls the json serializer to create the Model objects for data presentation.
     Calls the didGetSearchResults callback with the result on a successful object generation
     Calls returnFailedSearch in case of no data parsed
     */
    private func parseResults(resultsData: Data) {
        let serializer = JSONSerializer()
        
        if let result = serializer.serializeResponse(response: resultsData) {
            self.didGetSearchResults?(result)
        } else {
            self.returnFailedSearch(errorString: "Service Did not return valid information")
        }
    }
    
    /**
    Private function that uses the showGenericError callback to display the error form the service or a failed parse of the json serializer
     */
    private func returnFailedSearch(errorString: String) {
        self.showGenericError?(errorString)
    }
}
