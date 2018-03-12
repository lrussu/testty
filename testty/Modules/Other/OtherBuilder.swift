//
//  OtherBuilder.swift
//  testty
//
//  Created by Liudmila Russu on 20/02/2018.
//  Copyright © 2018 MyCompany. All rights reserved.
//

import UIKit
import Swinject

class OtherDefaultModuleBuilder: NSObject {

    fileprivate let container: Container
    
    init(parentContainer: Container) {
        container = Container(parent: parentContainer)
    }

    func build() -> OtherViewController! {

        container.register(OtherInteractor.self) { _ in
            OtherInteractorImp() //Add service
        }

        container.register(OtherViewController.self) { _ in

            OtherViewController(nibName: String(describing: OtherViewController.self), bundle: Bundle.main)

            }.initCompleted { container, view in

                view.presenter = container.resolve(OtherPresenter.self)
        }

        container.register(OtherRouter.self) { container in
            let router = OtherRouterImp()
            router.viewController = container.resolve(OtherViewController.self)!
            return router
        }

        container.register(OtherPresenter.self) { container in
            OtherPresenterImp(view: container.resolve(OtherViewController.self)!,
                                interactor: container.resolve(OtherInteractor.self)!,
                                router: container.resolve(OtherRouter.self)!)
        }

        return container.resolve(OtherViewController.self)!
    }
}
