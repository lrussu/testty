//
//  BreedPresenterTests.swift
//  testty
//
//  Created by Liudmila Russu on 27/02/2018.
//  Copyright © 2018 MyCompany. All rights reserved.
//

import XCTest
@testable import testty

class BreedPresenterTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    class MockInteractor: BreedInteractor {
        func getImageUrls(forBreedName: String, completion: @escaping (Result<[String]>) -> Void)
        {}
        
        func viewDidLoad() {
            
        }
        
        func viewDidSelectBreedCell(index: Int) {
            
        }
        
        func viewDidUpdateDataSourceWithBreedName() {
            
        }
        
        func viewDidUpdateDataSourceWithBreedImage() {
            
        }
        
        func viewDidUpdateDataSourceWithBreedImages() {
            
        }

        
        func getBreedImage(url: String, completion: @escaping (Result<Data>) -> Void) {
            
        }
        

    }

    class MockRouter: BreedRouter {

    }

    class MockViewController: BreedPresenter {
        func viewDidLoad() {
            
        }
        
        func viewDidSelectBreedCell(index: Int) {
            
        }
        
        func viewDidUpdateDataSourceWithBreedName() {
            
        }
        
        func viewDidUpdateDataSourceWithBreedImage() {
            
        }
        
        func viewDidUpdateDataSourceWithBreedImages() {
            
        }
        

    }
}
