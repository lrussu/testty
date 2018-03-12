//
//  BreedPresenter.swift
//  testty
//
//  Created by Liudmila Russu on 27/02/2018.
//  Copyright © 2018 MyCompany. All rights reserved.
//

import Foundation

protocol BreedPresenter {
    func viewDidLoad()
    func viewDidSelectBreedCell(index: Int)
    func viewDidUpdateDataSourceWithBreedName()
    func viewDidUpdateDataSourceWithBreedImage()
    func viewDidUpdateDataSourceWithBreedImages()
}

class BreedPresenterImp: BreedPresenter {

    weak var view: BreedView!
    var interactor: BreedInteractor!
    var router: BreedRouter!

    init(view: BreedView, interactor: BreedInteractor, router: BreedRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        
    }
    
    func viewDidSelectBreedCell(index: Int) {
        
    }
 
    func viewDidUpdateDataSourceWithBreedName() {
        DispatchQueue.global().async { [weak self] in
            
            guard let name = self?.view.getBreedNameFromDataSource() else {
                return
            }
            
            self?.interactor.getImageUrls(forBreedName: name) { [weak self] (result) in
                switch result {
                case .Success(let data):
                    self?.interactorDidRecieveImageUrls(data: data)
                case .Error(let message):
                    self?.interactorDidRecieveFail(message: message)
                }
            }
            
        }
    }
    
    func viewDidUpdateDataSourceWithBreedImages() {
        
    }
   
    func viewDidUpdateDataSourceWithBreedImage() {
        view.updateUI()
    }
    
    func interactorDidRecieveImageUrls(data: [String]) {

        let count = data.count
        
        DispatchQueue.concurrentPerform(iterations: count) { [weak self] (i) in
            
            let url = data[i]
            
            self?.interactor.getBreedImage(url: url) { [weak self] (result) in
                switch result {
                case .Success(let data):
                    self?.interactorDidRecieveBreedImage(data: data)
                case .Error(let message):
                    self?.interactorDidRecieveFail(message: message)
                }
            }
        }
    }
    
    func interactorDidRecieveFail(message: String) {
        router.showAlertWith(title: "Error", message: message)
    }
    
    func interactorDidRecieveBreedImage(data: Data) {
        view.updateDataSource(image: data)
    }
}
