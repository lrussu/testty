//
//  BreedRouter.swift
//  testty
//
//  Created by Liudmila Russu on 27/02/2018.
//  Copyright © 2018 MyCompany. All rights reserved.
//

import UIKit

protocol BreedRouter {

    func showAlertWith(title: String, message: String, style: UIAlertControllerStyle)
    
}

extension BreedRouter {
    func showAlertWith(title: String, message: String, style: UIAlertControllerStyle = .alert) {
        return showAlertWith(title: title, message: message, style: style)
    }
}

class BreedRouterImp: BreedRouter {

    weak var viewController: BreedViewController!

}
