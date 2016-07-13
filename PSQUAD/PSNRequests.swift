//
//  PSNRequests.swift
//  PSQUAD
//
//  Created by James Taylor on 2016-07-12.
//  Copyright © 2016 James Taylor. All rights reserved.
//

import Foundation

/// Request to fetch the profile of a user with the given `id`
struct ProfileRequest: Request {
    
    let url = "https://192.168.0.2/api/psn/profileOf"
    let parameters: [String: String]
    
    init(of id: String) {
        parameters = ["id": id]
    }
    
    func parse(json: JSON) -> User? {
        
        guard let jsonDict = json as? JSONDictionary else { return nil }
        
        return User(jsonDict: jsonDict)
    }
}

/// Request to fetch the friend list of a user with the given `id`
struct FriendListRequest: Request {
    
    let url = "https://192.168.0.2/api/psn/friendsOf"
    let parameters: [String: String]
    
    init(of id: String) {
        parameters = ["id": id]
    }
    
    func parse(json: JSON) -> [User]? {
        
        guard let jsonDict = json as? JSONDictionary,
            let friendListJSON = jsonDict["friendList"] as? JSONArray else { return nil }
        
        return friendListJSON
            .flatMap { $0 as? JSONDictionary }
            .flatMap(User.init)
    }
}

/// Request to fetch the online presence of a user with the given `id`
struct PresenceRequest: Request {
    
    let url = "https://192.168.0.2/api/psn/presenceOf"
    let parameters: [String: String]
    
    init(of id: String) {
        parameters = ["id": id]
    }
    
    func parse(json: JSON) -> Presence? {
        
        guard let jsonDict = json as? JSONDictionary else { return nil }
        
        return Presence(jsonDict: jsonDict)
    }
}
