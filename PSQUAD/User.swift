//
//  User.swift
//  PSQUAD
//
//  Created by James Taylor on 2016-07-11.
//  Copyright © 2016 James Taylor. All rights reserved.
//

import Foundation

/// Model for a single PSN user
struct User : JSONMappable {
    
    let id: String
    let avatarURL: String
    let presence: Presence
}

extension User {
    
    init?(json: JSON) {
        
        guard let jsonDict = json as? JSONDictionary,
            id = jsonDict["onlineId"] as? String,
            avatarURL = jsonDict["avatarUrl"] as? String else { return nil }
        
        self.id = id
        self.avatarURL = avatarURL
        
        if let presenceJSON = jsonDict["presence"],
            presence = Presence(json: presenceJSON) {
            self.presence = presence
        } else {
            self.presence = .unknown
        }
    }
}

extension User: CustomStringConvertible {
    var description: String { return "\(id)" }
}

extension User {
    
    var isOnline: Bool {
        
        switch self.presence {
        case .online: return true
        default: return false
        }
    }
}
