//
//  DashboardInteractorTests.swift
//  testty
//
//  Created by Liudmila Russu on 20/02/2018.
//  Copyright © 2018 MyCompany. All rights reserved.
//

import XCTest
import Swinject
@testable import testty


protocol Initializable {
    init()
}

class DashboardInteractorTests: XCTestCase {
    var interactor: DashboardInteractorImp!
    
    
    override func setUp() {
        super.setUp()
        
        let builder = DashboardDefaultModuleBuilder(parentContainer: Container())
        let viewController = builder.build()
        let presenter = viewController?.presenter as? DashboardPresenterImp
        interactor = presenter?.interactor as? DashboardInteractorImp
    }
    
    override func tearDown() {
        interactor = nil
        super.tearDown()
    }

    class MockPresenter: DashboardPresenter {
        func viewDidLoad() {}
        
        func viewDidTapedButtonLewisCarroll() {}
        
        func viewDidTapedButtonMain() {}
        
        func interactorDidRecieve(data: [String]?) {}
        
        func interactorDidRecieveFail(message: String) {}
    }

    class MockService<T>: APIService where T: Initializable {


        var getValueFromJSONGotCalled = false
        var requestDataGotCalled = false
        
        func getValueFromJSON<T>(query: String, key: String, expectedType: T.Type, completion: @escaping (Result<T>) -> Void) {
            getValueFromJSONGotCalled = true
           // completion(.Error("Error"))
            
                var instance = T()
                var s = Result<T>.Success(instance as! T)
                completion(s)

           //     completion(.Error("Error \(expectedType)"))

        }
        
    
        func requestData(endpoint: String, completion: @escaping (Result<Data>) -> Void) {
            completion(.Error("Error"))
            
            requestDataGotCalled = true
        }
        
    }
  
    func testGetBreedNamesCompletionOfInteractor() {
        
        let itemExpectation = expectation(description: "Interactor runs the callback")
        
        interactor.getBreedNames() { (result) in
            switch result {
                
            case .Success:
                XCTAssertTrue(true)
                
            case .Error(let message):
                XCTAssertTrue(false, "Interactor return fail result: \(message)")
            }
            
            itemExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("Wait for expectation is errored: \(error)")
            }
        }
    }
    
    
    func testFailInteractorAfterFailService() {
        
        let mockService = MockService()
        interactor.service = mockService
 
        let itemExpectation = expectation(description: "Interactor runs the callback")
        
        interactor.getBreedNames() { (result) in
            XCTAssertTrue(mockService.getValueFromJSONGotCalled, "service.getValueFromJSONGotCalled should have been called")
            switch result {
                
            case .Success:
                XCTAssertTrue(false, "Interactor should return fail using always faile mockservice")
                
            case .Error(let message):
                XCTAssertTrue(false, "Interactor should return fail result: \(message)")
            }
            
            itemExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("Wait for expectation is errored: \(error)")
            }
        }
        
    }
    
}
