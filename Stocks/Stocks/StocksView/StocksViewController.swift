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

extension StocksViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stocksResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StocksCell.identifier)

        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("This is a stub")
    }
    
}

private extension StocksViewController {
    
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
            self.tableView.reloadData()
        }
        
        self.viewModel?.showGenericError = { [weak self] errorMessage in
            guard let self = self else { return }
            self.buildAlert(errorMessage)
        }
    }
    
    func buildAlert(_ errorMessage: String) {
        let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "Ok",
            style: .default,
            handler: nil)

        alertController.addAction(actionOk)

        self.present(alertController, animated: true, completion: nil)
    }
}

