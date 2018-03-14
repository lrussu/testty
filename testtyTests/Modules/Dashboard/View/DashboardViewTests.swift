//
//  DashboardViewTests.swift
//  testty
//
//  Created by Liudmila Russu on 20/02/2018.
//  Copyright © 2018 MyCompany. All rights reserved.
//

import XCTest
import Swinject
@testable import testty

class DashboardViewTests: XCTestCase {

    class MockDashboardPresenter: DashboardPresenter {
        
        weak var view: DashboardView!
                
        var viewDidLoadGotCalled = false
        var viewDidTapedButtonLewisCarrollGotCalled = false
        var viewDidTapedButtonMainGotCalled = false
        
        func viewDidLoad() {
                viewDidLoadGotCalled = true
                view.setUpUI()
        }
        
        func viewDidTapedButtonLewisCarroll() {
            viewDidTapedButtonLewisCarrollGotCalled = true
        }
        
        func viewDidTapedButtonMain() {
            viewDidTapedButtonMainGotCalled = true
        }
        
        func interactorDidRecieve(data: [String]?) {}
        
        func interactorDidRecieveFail(message: String) {}
        
    }
    
    var viewController: DashboardViewController!
    
    override func setUp() {
        super.setUp()
        
        let builder = DashboardDefaultModuleBuilder(parentContainer: Container())
        
        viewController = builder.build()
    }

    override func tearDown() {
        viewController = nil
    
        super.tearDown()
    }
    
    func testPresenterIsInjectedInView() {
        XCTAssertNotNil(viewController.presenter, "Presenter not injected in View")
    }
    
    func testSetUpUI() {
        XCTAssertNotNil(viewController.presenter, "Presenter not injected in View")
    }

    func testCallsViewDidLoadOfPresenterAfterDidLoadingView() {
        
        let mockDashboardPresenter = MockDashboardPresenter()
        mockDashboardPresenter.view = viewController
        
        viewController.presenter = mockDashboardPresenter
        
        _ = viewController.view
        
        XCTAssert(mockDashboardPresenter.viewDidLoadGotCalled, "presenter.viewDidLoad should have been called")
    }
    
    func testCallsViewDidTapedButtonLewisCarrollOfPresenter() {
        let mockDashboardPresenter = MockDashboardPresenter()
        mockDashboardPresenter.view = viewController
        
        viewController.presenter = mockDashboardPresenter
        
        _ = viewController.view
    viewController.mainButton.sendAction(#selector(DashboardViewController.tappedButtonLewisCarroll), to: viewController, for: nil)
        
    XCTAssert(mockDashboardPresenter.viewDidTapedButtonLewisCarrollGotCalled, "presenter.viewDidTapedButtonLewisCarroll should have been called")
        
    }
    
    func testCallsViewDidTapedButtonMainOfPresenter() {
        let mockDashboardPresenter = MockDashboardPresenter()
        mockDashboardPresenter.view = viewController
        
        viewController.presenter = mockDashboardPresenter
        
        _ = viewController.view
    viewController.mainButton.sendAction(#selector(DashboardViewController.tappedButtonMain), to: viewController, for: nil)
 
        XCTAssert(mockDashboardPresenter.viewDidTapedButtonMainGotCalled, "presenter.viewDidTapedButtonMain should have been called")
        
    }
}
