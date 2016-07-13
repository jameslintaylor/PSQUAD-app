//
//  PSNRequest.swift
//  PSQUAD
//
//  Created by James Taylor on 2016-07-12.
//  Copyright © 2016 James Taylor. All rights reserved.
//

import Foundation

import Alamofire

protocol Request {
    
    associatedtype Data
    
    var url: String { get }
    var parameters: [String: String] { get }
    
    func parse(_: AnyObject) -> Data?
}

extension Result {
    
    func map<T>(@noescape transform: (Value) throws -> (T)) rethrows -> Result<T, Error> {
        switch self {
        case .Failure(let error): return .Failure(error)
        case .Success(let value): return .Success(try transform(value))
        }
    }
    
    func mapError<Error2>(@noescape transform: (Error) throws -> (Error2)) rethrows -> Result<Value, Error2> {
        switch self {
        case .Failure(let error): return .Failure(try transform(error))
        case .Success(let value): return .Success(value)
        }
    }
}

enum RequestError: ErrorType {
    
    case fetchError(NSError)
    case parseError
}

extension Request {
    
    func get(completion: (Result<Data, RequestError>) -> ()) {
        
        Network.local.request(.GET, url, parameters: parameters)
            .responseJSON { response in
                
                let result = response.result.mapError { return RequestError.fetchError($0) }
                result.ma
                
                switch response.result.map(self.parse) {
                
                // Network failure, just relay error
                case .Failure(let error): completion(.Failure(.fetchError(error)))
                    
                // Parse error
                case .Success(.None): completion(.Failure(.parseError))
                    
                // Successful parse
                case .Success(.Some(let data)): completion(.Success(data))
                }
            }
    }
}
