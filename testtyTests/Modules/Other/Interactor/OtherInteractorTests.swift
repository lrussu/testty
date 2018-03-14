//
//  OtherInteractorTests.swift
//  testty
//
//  Created by Liudmila Russu on 20/02/2018.
//  Copyright © 2018 MyCompany. All rights reserved.
//

import XCTest
@testable import testty

class OtherInteractorTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    class MockPresenter: OtherInteractor {
        func getBreedImageUrl(breedName: String, completion: @escaping (Result<String>) -> Void) {
            
        }
        
        func getBreedImage(url: String, completion: @escaping (Result<Data>) -> Void) {
            
        }
        

    }
}
