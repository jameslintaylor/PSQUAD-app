//
//  PSNModel.swift
//  PSQUAD
//
//  Created by James Taylor on 2016-07-14.
//  Copyright © 2016 James Taylor. All rights reserved.
//

import Foundation

import RxSwift
import RxMoya

struct PSNModel {
    
    let provider: RxMoyaProvider<PSN>

    func findUser(named id: String) -> Observable<User> {
        
        return provider.request(.profile(of: id))
//            .debug()
            .mapObject(User)
    }
    
    func findFriends(of id: String) -> Observable<[User]> {
        
        return provider.request(.friends(of: id))
//            .debug()
            .mapArray(User)
            .catchError { error in
                return Observable.never()
            }
    }
    
    func findPresence(of id: String) -> Observable<Presence> {
        
        return provider.request(.presence(of: id))
//            .debug()
            .mapObject(Presence)
            .catchErrorJustReturn(.unknown)
    }
}

extension PSNModel {
    
    func trackFriends(of id: Observable<String>) -> Observable<[User]> {
        
        return id
            
            .flatMapLatest { id in
                self.findFriends(of: id)
            }
        
    }
    
    func trackPresences(of ids: Observable<[User]>) -> Observable<[User]> {
        
        return ids
            
            .flatMapLatest { friends in
                
                // To array of streams returning a presence for each friend
                friends.map { friend in
                    
                    self.findPresence(of: friend.id)
                        
                        // reconstruct user with the presence
                        .map { presence in
                            return User(
                                id: friend.id,
                                avatarURL: friend.avatarURL,
                                presence: presence
                            )
                        }
                    
                    // Into single observable emitting an event once all presence requests are answered.
                    }.zip { $0 }
        }
    }
}