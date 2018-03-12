//
//  DashboardInteractor.swift
//  testty
//
//  Created by Liudmila Russu on 20/02/2018.
//  Copyright © 2018 MyCompany. All rights reserved.
//

import Foundation

protocol DashboardInteractor {
   
    func getBreedNames(completion: @escaping (Result<[String]>) -> Void)
}

class DashboardInteractorImp: DashboardInteractor {
    
    func getBreedNames(completion: @escaping (Result<[String]>) -> Void) {
        let service = APIService.sharedInstance
        let query = "breeds/list"
       
        service.getValueFromJSON(query: query, key: "message", expectedType: [String].self) { (result) in
            switch result {
                
                case .Success(let breedNames):
                    completion(.Success(breedNames))

                case .Error(let message):
                    completion(.Error(message))
            }
        }
    }
    

}
