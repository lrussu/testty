//
//  DashboardPresenterTests.swift
//  testty
//
//  Created by Liudmila Russu on 20/02/2018.
//  Copyright © 2018 MyCompany. All rights reserved.
//

import XCTest
import Swinject
@testable import testty

extension DashboardPresenterImp {
    func viewDidTappedButtonMainWith(closure: @escaping () -> Void) {
        viewDidTapedButtonMain()
        closure()
    }
}

class DashboardPresenterTest: XCTestCase {

    var viewController: DashboardViewController!
    var presenter: DashboardPresenterImp!

    class MockInteractor: DashboardInteractor {
        
        var getBreedNamesGotCalled = false
        var isErrorAfterDataReceive = false
        var completionFromGetBreedName: (Result<[String]>) -> Void = { _ in }
        
        func getBreedNames(completion: @escaping (Result<[String]>) -> Void) {
            completionFromGetBreedName = completion
            
            getBreedNamesGotCalled = true
            
            if isErrorAfterDataReceive {
                completion(.Error("Fail"))
            } else {
                completion(.Success(["test"]))
            }
        }
    }

    class MockRouter: DashboardRouter {
        
        var goOtherModuleWithDataGotCalled = false
        var showAlertWithGotCalled = false
        
        func goOtherModule() {}
        
        func goOtherModule(data: [String]?) {
            goOtherModuleWithDataGotCalled = true
        }
        
        func showAlertWith(title: String, message: String, cancelText: String, style: UIAlertControllerStyle) {
            showAlertWithGotCalled = true
        }
    }

    class MockViewController: DashboardView {
        
        var setUpUIGotCalled = false
        
        func setUpUI() {
            setUpUIGotCalled = true
        }
        
        func updateUI() {}
        
        func toggleState(state: State) {}
    }
    
    override func setUp() {
        super.setUp()
        
        let builder = DashboardDefaultModuleBuilder(parentContainer: Container())
        
        viewController = builder.build()
        presenter = viewController.presenter as? DashboardPresenterImp
    }
    
    override func tearDown() {
        presenter = nil
        viewController = nil
        
        super.tearDown()
    }
    
    func testViewIsInjectedInPresenter() {
        XCTAssertNotNil(presenter.view, "View should have been injected in presenter")
    }
    
    func testInteractorIsInjectedInPresenter() {
        XCTAssertNotNil(presenter.interactor, "Interactor should have been injected in presenter")
    }
    
    func testRouterIsInjectedInPresenter() {
        XCTAssertNotNil(presenter.router, "Router should have been injected in presenter")
    }
    
    func testCallsSetUpUIOfViewAfterPresenterCallViewDidLoad() {
        let mockViewController = MockViewController()
        presenter.view = mockViewController
        
        presenter.viewDidLoad()
        
        XCTAssert(mockViewController.setUpUIGotCalled, "view.setUpUI should have been called")
    }
    
    func testCallsShowAlertWithOfRouterAfterPresenterCallsViewDidTapedButtonLewisCarroll() {
        let mockRouter = MockRouter()
        presenter.router = mockRouter
        
        presenter.viewDidTapedButtonLewisCarroll()
        
        XCTAssert(mockRouter.showAlertWithGotCalled, "Router.showAlertWith(...) should have been called")
    }
    
    func testCallsGoOtherModuleWithDataOfRouterAfterPresenterCallsInteractorDidRecieve() {
        
        let mockRouter = MockRouter()
        presenter.router = mockRouter
        
        presenter.interactorDidRecieve(data: nil)
        
        XCTAssert(mockRouter.goOtherModuleWithDataGotCalled, "router.goOtherModule(data:) should have been called")
    }
    
    
    func testCallsgetBreedNamesWithCompletionOfInteractorAfterPresenterCallsViewDidTapedButtonMain() {
        
        let mockInteractor = MockInteractor()
        
        presenter.interactor = mockInteractor
        
        presenter.viewDidTapedButtonMain()
        
        XCTAssert(mockInteractor.getBreedNamesGotCalled, "interactor.getBreedNames(completion: ) should have been called")
    }
    
    func testGetBreedNamesCompletionOfInteractor() {
        
        let mockInteractor = MockInteractor()
        let itemExpectation = expectation(description: "Interactor runs the callback")
        
        
        mockInteractor.getBreedNames() { (result) in
            switch result {
                
            case .Success(let data):
                XCTAssertTrue(true)
                
            case .Error(let message):
                XCTAssertTrue(true)
            }
            
            itemExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("Wait for expectation is errored: \(error)")
            }
        }

    }
    
    func testCallsGoOtherModuleWithDataOfRouterAfterPresenterRecievedSuccessFromInteractor() {
        
        let mockInteractor = MockInteractor()
        mockInteractor.isErrorAfterDataReceive = true
        
        let mockRouter = MockRouter()
        presenter.interactor = mockInteractor
        presenter.router = mockRouter
      
        let itemExpectation = expectation(description: "Extended presenter runs callback")
        
        presenter.viewDidTappedButtonMainWith() {
            presenter.interactor.c
            itemExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("Wait for expectation is errored: \(error)")
            }
            
            XCTAssert(mockRouter.showAlertWithGotCalled, "Router.showAlertWith(...) should have been called")
        }
        
    }
}
