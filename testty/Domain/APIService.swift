//
//  APIService.swift
//  testty
//
//  Created by Liudmila Russu on 2/23/18.
//  Copyright © 2018 Liudmila Russu. All rights reserved.
//

import UIKit

enum Result<T> {
    case Success(T)
    case Error(String)
}

typealias JSON = [String: Any]

protocol APIService: class {
    func getValueFromJSON<T>(query: String, key: String, expectedType: T.Type, completion: @escaping (Result<T>) -> Void)
    func requestData(endpoint: String, completion: @escaping (Result<Data>) -> Void )
}

class DogService: APIService {
    static let sharedInstance = DogService()
    let base = "https://dog.ceo/api/"
    
    func requestData(endpoint: String, completion: @escaping (Result<Data>) -> Void) {
        guard let url = URL(string: endpoint) else {
            return
        }
        let request = URLRequest(url: url)
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) {
            (data, response, error) in
            if let error = error {
                completion(.Error("Error request: \(error) \(error.localizedDescription)"))
                return
            }

            if response == nil {
                completion(.Error("Error response nil"))
                return
            }
            
            if let responseCast = response as? HTTPURLResponse {
                if responseCast.statusCode != 200 {
                    completion(.Error("Response status Code is not expected 200: \(responseCast.statusCode)"))
                }
            }
            
            guard let data = data else {
                completion(.Error("Error data nil"))
                return
            }
            
            completion(.Success(data))
        }
        
        task.resume()
    }
    
    func getValueFromJSON<T>(query: String, key: String, expectedType: T.Type, completion: @escaping (Result<T>) -> Void) {

        getJSON(query: query) { (result) in
            switch result {
                
            case .Success(let json):
                guard let value = json[key] else {
                    completion(.Error("JSON don't contains key \(key)"))
                    return
                }
                guard let valueCast = value as? T else {
                    completion(.Error("Value \(value) is not expected \(T.self)"))
                    return
                }
                completion(.Success(valueCast))
                
            case .Error(let message):
                completion(.Error(message))
            }
        }
    }
    
    func getJSON(query: String, completion: @escaping (Result<JSON>) -> Void) {
        
        getData(query: query) { (result) in
            switch result {
                
            case .Success(let data):
                do {
                    let json = try self.toJSON(data)
                    completion(.Success(json))
                } catch {
                    let error = error as NSError
                    completion(.Error("\(error.userInfo)"))
                }
            case .Error(let message):
                completion(.Error(message))
            }
        }
    }
    
    func buildEndpoint(_ query: String) -> String {
        return "\(base)\(query)"
    }
    
    func getData(query: String, completion: @escaping (Result<Data>) -> Void) {
        
        requestData(endpoint: buildEndpoint(query)) { (result) in
            switch result {
                
            case .Success(let data):
                completion(.Success(data))
                
            case .Error(let message):
                completion(.Error(message))
            }
        }
    }
    
    enum ErrorJSON: Error {
        case FailSerialize(String)
    }
    
    func toJSON(_ data: Data) throws -> JSON {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            guard let jsonCast = json as? JSON else {
                throw ErrorJSON.FailSerialize("Result uncastable to custom JSON type")
            }
            return jsonCast
        }  catch {
            let error = error as NSError
            throw ErrorJSON.FailSerialize("\(error), \(error.userInfo)")
        }
    }
}
