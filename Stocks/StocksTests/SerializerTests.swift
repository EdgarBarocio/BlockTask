//
//  SerializerTests.swift
//  StocksTests
//
//  Created by Edgar Barocio on 7/27/23.
//

import XCTest
@testable import Stocks

final class SerializerTests: XCTestCase {
    
    var sut: JSONSerializer?
    
    override func setUpWithError() throws {
        sut = JSONSerializer()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_JSONSerializer_CorrectJson() throws {
        
        let correctData = fetchSuccessJson()
        
        let evaluation = sut?.serializeResponse(response: correctData)
        XCTAssertNotNil(evaluation, "Empty json should return data")
        XCTAssertEqual(1, evaluation?.count, "Evaluation should have one element")
    }
    
    func test_JSONSerializer_EmptyJson() throws {
        let emptyData = fetchEmptyJson()
       
        let evaluation = sut?.serializeResponse(response: emptyData)
        XCTAssertNotNil(evaluation, "Empty json should return data")
        XCTAssertEqual(0, evaluation?.count, "Evaluation should be empty")
    }
    
    func test_JSONSerializer_MalformedJson() throws {
        let malformedData = fetchMalformedJson()
       
        let evaluation = sut?.serializeResponse(response: malformedData)
        XCTAssertNil(evaluation, "Malformed json should return nil")
    }
    
    func fetchMalformedJson() -> Data {
        let json = """
        {"stocks":[{"ticker":"^GSPC","name":"S&P 500","currency":"USD","current_price_cents":318157,"quantity":null,"current_price_timestamp":1681845832}]}malformedmalformedmalformed
        """
        let data = Data(json.utf8)
        return data
    }
    
    func fetchEmptyJson() -> Data {
        let json = """
        {
            "stocks": []
        }
        """
        let data = Data(json.utf8)
        return data
    }
    
    func fetchSuccessJson() -> Data {
        let json = """
        {"stocks":[{"ticker":"^GSPC","name":"S&P 500","currency":"USD","current_price_cents":318157,"quantity":null,"current_price_timestamp":1681845832}]}
        """
        
        let data = Data(json.utf8)
        return data
    }
}
