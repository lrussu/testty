//
//  DashboardPresenter.swift
//  testty
//
//  Created by Liudmila Russu on 20/02/2018.
//  Copyright © 2018 MyCompany. All rights reserved.
//

import Foundation

protocol DashboardPresenter {
    func viewDidLoad()
    func viewDidTapedButtonLewisCarroll()
    func mainButtonTapped()
    func interactorDidRecieve(data: [String]?)
    func interactorDidRecieveFail(message: String)
}

class DashboardPresenterImp: DashboardPresenter {

    weak var view: DashboardView!
    var interactor: DashboardInteractor!
    var router: DashboardRouter!

    init(view: DashboardView, interactor: DashboardInteractor, router: DashboardRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        view.setUpUI()
    }

    
    func mainButtonTapped() {       
        interactor.getBreedNames() {
            [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .Error(let message):
                    self?.interactorDidRecieveFail(message: message)
                case .Success(let data):
                    self?.interactorDidRecieve(data: data)
                }
            }
        }
    }
    
    func interactorDidRecieveFail(message: String) {
        self.router.showAlertWith(title: "Error", message: message)
    }
    
    func viewDidTapedButtonLewisCarroll() {
        let title = NSLocalizedString("poem_title", comment: "")
        let message = NSLocalizedString("jabberwockye_content", comment: "")
        let cancelButtonText = NSLocalizedString("cancel", comment: "")
        self.router.showAlertWith(title: title, message: message, cancelText: cancelButtonText)
    }
    
    func interactorDidRecieve(data: [String]?) {
        router.goOtherModule(data: data)
    }
    
}
