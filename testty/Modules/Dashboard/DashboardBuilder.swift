//
//  DashboardBuilder.swift
//  testty
//
//  Created by Liudmila Russu on 20/02/2018.
//  Copyright © 2018 MyCompany. All rights reserved.
//

import UIKit
import Swinject

class DashboardDefaultModuleBuilder: NSObject {

    fileprivate let container: Container
    
    init(parentContainer: Container) {
        container = Container(parent: parentContainer)
    }

    func build() -> DashboardViewController! {

        container.register(DashboardInteractor.self) { _ in
            DashboardInteractorImp() //Add service
        }

        container.register(DashboardViewController.self) { _ in

            DashboardViewController(nibName: String(describing: DashboardViewController.self), bundle: Bundle.main)

            }.initCompleted { container, view in

                view.presenter = container.resolve(DashboardPresenter.self)
        }

        container.register(DashboardRouter.self) { container in
            let router = DashboardRouterImp()
            router.viewController = container.resolve(DashboardViewController.self)!
            return router
        }

        container.register(DashboardPresenter.self) { container in
            DashboardPresenterImp(view: container.resolve(DashboardViewController.self)!,
                                interactor: container.resolve(DashboardInteractor.self)!,
                                router: container.resolve(DashboardRouter.self)!)
        }

        return container.resolve(DashboardViewController.self)!
    }
}
