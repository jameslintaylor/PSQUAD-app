//
//  User.swift
//  PSQUAD
//
//  Created by James Taylor on 2016-07-11.
//  Copyright © 2016 James Taylor. All rights reserved.
//

import Foundation

/// Model for a single PSN user
struct User {
    
    let id: String
    let avatarURL: String
    let presence: Presence
    
    init?(jsonDict: JSONDictionary) {
        
        guard let id = jsonDict["onlineId"] as? String,
            let avatarURL = jsonDict["avatarUrl"] as? String else { return nil }
        
        self.id = id
        self.avatarURL = avatarURL
        
        if
            let presenceDict = jsonDict["presence"] as? JSONDictionary,
            let presence = Presence(jsonDict: presenceDict) {
            self.presence = presence
        } else {
            self.presence = .unknown
        }
    }
}

extension User: CustomStringConvertible {
    var description: String { return "\(id)" }
}
