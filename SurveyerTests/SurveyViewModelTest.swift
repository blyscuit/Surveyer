//
//  SurveyViewModelTest.swift
//  SurveyerTests
//
//  Created by Pisit W on 12/6/2563 BE.
//  Copyright © 2563 blyscuit. All rights reserved.
//


import XCTest
@testable import Surveyer

import Alamofire

class SurveyViewModelTest: XCTestCase {
    
    var viewModel : HomeViewModel!
    var dataSource : GenericDataSource<HotelModel>!
    fileprivate var service : MockSurveyService!
    
    override func setUp() {
        super.setUp()
        self.service = MockSurveyService()
        self.dataSource = GenericDataSource<HotelModel>()
        self.viewModel = HomeViewModel(service: service, dataSource: dataSource)
    }
    
    override func tearDown() {
        self.viewModel = nil
        self.dataSource = nil
        self.service = nil
        super.tearDown()
    }
    
    func testFetchWithNoService() {
        
        let expectation = XCTestExpectation(description: "No service survey")
        
        // giving no service to a view model
        viewModel.service = nil
        
        viewModel.networkStatus.addObserver(self, completionHandler: { state in
            switch state {
            case .error:
                expectation.fulfill()
            default:
                break
            }
        })
        
        viewModel.getData()
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchSurveys() {
        
        let expectation = XCTestExpectation(description: "Survey fetch")
        
        // giving a service mocking currencies
        service.models = [HotelModel(JSON: [:])!]
        
        dataSource.data.addObserver(self) { _ in
            expectation.fulfill()
        }
        
        viewModel.getData()
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchNoSurveys() {
        
        let expectation = XCTestExpectation(description: "No Survey")
        
        // giving a service mocking error during fetching currencies
        service.models = []
        
        dataSource.data.addObserver(self) { dataSource in
            if dataSource.count == 0 {
                expectation.fulfill()
            }
        }
        
        viewModel.getData()
        wait(for: [expectation], timeout: 5.0)
    }
}

fileprivate class MockSurveyService : SurveyServiceProtocol {
    
    var models : [HotelModel]?
    
    func getSurveys(page: Int, perPage: Int, completionHandler: @escaping ([HotelModel]?, Error?) -> Void) -> Alamofire.Request {
        if let models = models {
            completionHandler(models, nil)
        } else {
            completionHandler(nil, NetworkError(description: "", code: 201))
        }
        return Alamofire.request(URL(string: "Test")!)
    }
}

