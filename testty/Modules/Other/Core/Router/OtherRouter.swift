//
//  OtherRouter.swift
//  testty
//
//  Created by Liudmila Russu on 20/02/2018.
//  Copyright © 2018 MyCompany. All rights reserved.
//

import Foundation
import UIKit
import Swinject

protocol OtherRouter {

    func showAlertWith(title: String, message: String, style: UIAlertControllerStyle)
    func goBreedModule(data: Breed)
    
}

extension OtherRouter {
    func showAlertWith(title: String, message: String, style: UIAlertControllerStyle = .alert) {
        return showAlertWith(title: title, message: message, style: style)
    }
}

class OtherRouterImp: OtherRouter {

    weak var viewController: OtherViewController!
    
    func showAlertWith(title: String, message: String, style: UIAlertControllerStyle = .alert) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let action = UIAlertAction(title: title, style: .default) { (action) in
            self.viewController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(action)
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    func goBreedModule(data: Breed) {
        let navigation = viewController.navigationController
        let stack = navigation?.viewControllers
        
        if let breedViewController = stack?.first(where: { $0 is BreedViewController }) as? BreedViewController {
            breedViewController.updateDataSource(breed: data)
            navigation?.popToViewController(breedViewController, animated: true)
        } else {
            guard let breedViewController = BreedDefaultModuleBuilder(parentContainer: Container()).build() else {
                return
            }
            breedViewController.updateDataSource(breed: data)
            navigation?.pushViewController(breedViewController, animated: true)
        }
    }

}
