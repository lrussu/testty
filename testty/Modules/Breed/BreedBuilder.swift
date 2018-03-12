//
//  BreedBuilder.swift
//  testty
//
//  Created by Liudmila Russu on 27/02/2018.
//  Copyright © 2018 MyCompany. All rights reserved.
//

import UIKit
import Swinject

class BreedDefaultModuleBuilder: NSObject {

    fileprivate let container: Container
    
    init(parentContainer: Container) {
        container = Container(parent: parentContainer)
    }

    func build() -> BreedViewController! {

        container.register(BreedInteractor.self) { _ in
            BreedInteractorImp() //Add service
        }

        container.register(BreedViewController.self) { _ in

            BreedViewController(nibName: String(describing: BreedViewController.self), bundle: Bundle.main)

            }.initCompleted { container, view in

                view.presenter = container.resolve(BreedPresenter.self)
        }

        container.register(BreedRouter.self) { container in
            let router = BreedRouterImp()
            router.viewController = container.resolve(BreedViewController.self)!
            return router
        }

        container.register(BreedPresenter.self) { container in
            BreedPresenterImp(view: container.resolve(BreedViewController.self)!,
                                interactor: container.resolve(BreedInteractor.self)!,
                                router: container.resolve(BreedRouter.self)!)
        }

        return container.resolve(BreedViewController.self)!
    }
}
