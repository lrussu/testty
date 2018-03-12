//
//  OtherPresenter.swift
//  testty
//
//  Created by Liudmila Russu on 20/02/2018.
//  Copyright © 2018 MyCompany. All rights reserved.
//

import Foundation

protocol OtherPresenter {
    func viewDidLoad()
    func viewDidUpdateDataSourceWithBreedNames()
    func viewDidUpdateDataSourceWithBreedImages()
    func viewDidSelectBreedCell(index: Int)
}

class OtherPresenterImp: OtherPresenter {

    weak var view: OtherView!
    var interactor: OtherInteractor!
    var router: OtherRouter!

    init(view: OtherView, interactor: OtherInteractor, router: OtherRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        view.updateUI()
    }
    
    func viewDidUpdateDataSourceWithBreedNames() {
        DispatchQueue.global().async { [weak self] in
            guard let breeds = self?.view.getBreedsFromDataSource() else {
                return
            }
         
            let count = breeds.count
            
            DispatchQueue.concurrentPerform(iterations: count) { [weak self] (i) in
        
                let name = breeds[i].name
                    
                    self?.interactor.getBreedImageUrl(breedName: name) { [weak self, name] (result) in
                        switch result {
                        case .Success(let data):
                            self?.interactorDidRecieveBreedImageUrl(data: data, forBreedName: name)
                        case .Error(let message):
                            self?.interactorDidRecieveFail(message: message)
                        }
                    }
            }
        }

    }

    func viewDidUpdateDataSourceWithBreedImages() {
        view.updateUI()
    }

    func interactorDidRecieveFail(message: String) {
        router.showAlertWith(title: "Error", message: message)
    }


    func interactorDidRecieveBreedImageUrl(data: String, forBreedName: String) {
        DispatchQueue.global().async { [weak self] in
            self?.interactor.getBreedImage(url: data) { [weak self] (result) in
                switch result {
                case .Success(let data):
                    DispatchQueue.main.async {
                        self?.interactorDidRecieveBreedImage(data: data, forBreedName: forBreedName)
                    }
                case .Error(let message):
                    self?.interactorDidRecieveFail(message: message)
                }
            }
        }
    }
    
    func interactorDidRecieveBreedImage(data: Data, forBreedName: String) {
        view.updateDataSource(image: data, forBreedName: forBreedName)
    }
    
    func viewDidSelectBreedCell(index: Int) {
        if let breed = view.getBreedFromDataSource(by: index) {
            router.goBreedModule(data: breed)
        }
    }
}
