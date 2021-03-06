//
//  BreedBuilderTests.swift
//  testty
//
//  Created by Liudmila Russu on 27/02/2018.
//  Copyright © 2018 MyCompany. All rights reserved.
//

import XCTest
import Swinject
@testable import testty

class BreedModuleBuilderTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testConfigureModuleForViewController() {
        let builder = BreedDefaultModuleBuilder(parentContainer: Container())
        let viewController = builder.build()

        XCTAssertNotNil(viewController, "BreedViewController is nil after configuration")
    }
}
