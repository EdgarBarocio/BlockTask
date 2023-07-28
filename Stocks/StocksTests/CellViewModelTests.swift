//
//  CellViewModelTests.swift
//  StocksTests
//
//  Created by Edgar Barocio on 7/27/23.
//

import XCTest
@testable import Stocks

final class CellViewModelTests: XCTestCase {
    
    var sut: StocksCellViewModel?
    
    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_ViewModelInit_ShouldHaveAllValue() {
        sut = StocksCellViewModel(ticker: "^GSPC",
                                  name: "S&P 500",
                                  currency: "USD",
                                  price: 318157,
                                  quantityOwned: 0,
                                  timeStamp: 1681845832)
        
        XCTAssertNotNil(sut?.ticker, "Ticker should have a value")
        XCTAssertNotNil(sut?.name, "Name should have a value")
        XCTAssertNotNil(sut?.currency, "Currency should have a value")
        XCTAssertNotNil(sut?.price, "Price should have a value")
        XCTAssertNotNil(sut?.quantityOwned, "Quantity should have a value")
        XCTAssertNotNil(sut?.timeStamp, "TimeStamp should have a value")
        XCTAssertNotEqual(sut?.priceString, "", "Property should have a currency value")
        XCTAssertNotEqual(sut?.timeStampString, "", "Property should have a Date String")
    }
}
