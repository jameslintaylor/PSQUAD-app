//
//  JSONMappable.swift
//  PSQUAD
//
//  Created by James Taylor on 2016-07-13.
//  Copyright © 2016 James Taylor. All rights reserved.
//

import Foundation

import RxMoya
import RxSwift

protocol JSONMappable {
    init?(json: JSON)
}

extension Response {
    
    func mapObject<T: JSONMappable>(type: T.Type) throws -> T {
                
        guard let object = T(json: try mapJSON()) else { throw Error.JSONMapping(self) }
        return object
    }
    
    func mapArray<T: JSONMappable>(type: T.Type) throws -> [T] {
        
        guard let jsonArray = try mapJSON() as? JSONArray else { throw Error.JSONMapping(self) }
        return jsonArray.flatMap(T.init)
    }
}

extension ObservableType where E == Response {
    
    func mapObject<T: JSONMappable>(type: T.Type) -> Observable<T> {
        
        return flatMap { response -> Observable<T> in
            return Observable.just(try response.mapObject(T))
        }
    }
    
    func mapArray<T: JSONMappable>(type: T.Type) -> Observable<[T]> {
        
        return flatMap { response -> Observable<[T]> in
            return Observable.just(try response.mapArray(T))
        }
    }
}
