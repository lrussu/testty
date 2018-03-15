//
//  ServiceBuilder.swift
//  testty
//
//  Created by Liudmila Russu on 3/15/18.
//  Copyright © 2018 Liudmila Russu. All rights reserved.
//

import Foundation
import Swinject

class ServiceBuilder {
    
    static let sharedInstance = ServiceBuilder()
    
    let container = Container()
    
    init() {
        self.container.register(APIService.self) { _ in
            DogService.sharedInstance
        }
    }
}
