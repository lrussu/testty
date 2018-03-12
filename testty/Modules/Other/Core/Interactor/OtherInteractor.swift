//
//  OtherInteractor.swift
//  testty
//
//  Created by Liudmila Russu on 20/02/2018.
//  Copyright © 2018 MyCompany. All rights reserved.
//

import Foundation

protocol OtherInteractor {
    func getBreedImageUrl(breedName: String, completion: @escaping (Result<String>) -> Void)
    func getBreedImage(url: String, completion: @escaping (Result<Data>) -> Void)
}



class OtherInteractorImp: OtherInteractor {
    let service = APIService.sharedInstance
    
    func getBreedImageUrl(breedName: String, completion: @escaping (Result<String>) -> Void) {
       
        let query = "breed/\(breedName)/images/random"
        service.getValueFromJSON(query: query, key: "message", expectedType: String.self) { (result) in
            switch result {
                
            case .Success(let data):
                completion(.Success(data))
                
            case .Error(let message):
                completion(.Error(message))
            }
        }
    }
    
    func getBreedImage(url: String, completion: @escaping (Result<Data>) -> Void) {
        service.requestData(endpoint: url) { (result) in
            switch result {
        
            case .Success(let data):
                completion(.Success(data))
        
            case .Error(let message):
                completion(.Error(message))
            }
        }
    }
}
