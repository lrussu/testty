//
//  DashboardRouter.swift
//  testty
//
//  Created by Liudmila Russu on 20/02/2018.
//  Copyright © 2018 MyCompany. All rights reserved.
//

import Foundation
import Swinject


protocol DashboardRouter {
 //   func go<T: UIViewController,B: DefaultModuleBuilder>(moduleType: T.Type, builderType: B.Type)
    func goOtherModule()
    func goOtherModule(data: [String]?)
    func showAlertWith(title: String, message: String, cancelText: String, style: UIAlertControllerStyle)

}

extension DashboardRouter {
    func showAlertWith(title: String, message: String, cancelText: String = "", style: UIAlertControllerStyle = .alert) {
        return showAlertWith(title: title, message: message, cancelText: cancelText, style: style)
    }
    
}


class DashboardRouterImp: DashboardRouter {
   
    weak var viewController: DashboardViewController!

    func goOtherModule() {
        let navigation = viewController.navigationController
        let stack = navigation?.viewControllers
        
        if let otherViewController = stack?.first(where: { $0 is OtherViewController }) as? OtherViewController {
            navigation?.popToViewController(otherViewController, animated: true)
        } else {
            guard let otherViewController = OtherDefaultModuleBuilder(parentContainer: Container()).build() else {
                return
            }
            navigation?.pushViewController(otherViewController, animated: true)
        }
    }
    
    
    func goOtherModule(data: [String]?) {
        let navigation = viewController.navigationController
        let stack = navigation?.viewControllers
        
        if let otherViewController = stack?.first(where: { $0 is OtherViewController }) as? OtherViewController {
            otherViewController.updateDataSource(breedNames: data)
            navigation?.popToViewController(otherViewController, animated: true)
        } else {
            guard let otherViewController = OtherDefaultModuleBuilder(parentContainer: Container()).build() else {
                return
            }            
            otherViewController.updateDataSource(breedNames: data)
            navigation?.pushViewController(otherViewController, animated: true)
        }
        
    }
    
    func showAlertWith(title: String, message: String, cancelText: String = "", style: UIAlertControllerStyle = .alert) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let action = UIAlertAction(title: cancelText, style: .default) { (action) in
            self.viewController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(action)
        viewController.present(alertController, animated: true, completion: nil)
    }
}
