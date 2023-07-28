//
//  ViewController.swift
//  Stocks
//
//  Created by Edgar Barocio on 7/22/23.
//

import UIKit

class StocksViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var viewModel: StocksViewModel?
    private var stocksResult: [StocksModel.Stocks] = [StocksModel.Stocks]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Current Stock Information"
        
        self.viewModel = StocksViewModel(services: ServiceCalls())
        self.setupCallbacks()
        self.viewModel?.fetchStockInfo()
    }
}

//MARK: - Extension that implements datasource and delegate for the TableView
extension StocksViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stocksResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StocksCell.identifier) as? StocksCell
        
        let cellViewModel = StocksCellViewModel(ticker: self.stocksResult[indexPath.row].ticker,
                                                name: self.stocksResult[indexPath.row].name,
                                                currency: self.stocksResult[indexPath.row].currency,
                                                price: self.stocksResult[indexPath.row].currentPrice,
                                                quantityOwned: self.stocksResult[indexPath.row].quantity ?? 0,
                                                timeStamp: self.stocksResult[indexPath.row].timeStamp)
        cell?.configure(cellViewModel)

        return cell ?? UITableViewCell()
    }
}

//MARK: - Private extension to setup callbacks and private functions
private extension StocksViewController {
    
    /**
    Function that implements all actions the view takes with the data provided by the view model
     
     showLoading: Displays the activity indicator
     dismissLoading: Hides the activity indicator
     didGetSearchResults: A successful serialization was received form data, but this can also display the empty results error
     showGenericError: Builds an error message displayed as the Tableview Background
     */
    func setupCallbacks() {
        self.viewModel?.showLoading = { [weak self] in
            guard let self = self else { return }
            self.activityIndicator.startAnimating()
            self.activityIndicator.isHidden = false
        }
        
        self.viewModel?.dismissLoading = { [weak self] in
            guard let self = self else { return }
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
        
        self.viewModel?.didGetSearchResults = { [weak self] results in
            guard let self = self else { return }
            
            self.stocksResult = results
            
            if self.stocksResult.isEmpty {
                self.buildAlert("No Results Available")
            } else {
                self.tableView.restore()
            }
            self.tableView.reloadData()
        }
        
        self.viewModel?.showGenericError = { [weak self] errorMessage in
            guard let self = self else { return }
            self.buildAlert(errorMessage)
        }
    }
    
    /**
    Function that displays the error message sent from empty results, failed response or malformed results as a
     table view background
     */
    func buildAlert(_ errorMessage: String) {
        self.tableView.setEmptyMessage(errorMessage)
    }
}

//MARK: - UITableView extension used to handle error messaging
extension UITableView {

    /**
    Function that creates the error message view and sets it as the tableview backgroundView
     */
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    /**
    Function that removes the background view
     */
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}

