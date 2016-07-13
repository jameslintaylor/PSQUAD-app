//
//  Presence.swift
//  PSQUAD
//
//  Created by James Taylor on 2016-07-11.
//  Copyright © 2016 James Taylor. All rights reserved.
//

import Foundation

/// State of a user's presence at a moment in time
enum Presence {
    
    case unknown
    case online(game: String?)
    case offline(lastOnline: NSDate?)
    
    init?(jsonDict: JSONDictionary) {
        
        guard let primaryInfo = jsonDict["primaryInfo"] as? JSONDictionary,
            onlineStatus = primaryInfo["onlineStatus"] as? String else { return nil }
        
        switch onlineStatus {
        
        case "online":
            self = .online(game: nil)
        
        case "offline":
            self = .offline(lastOnline: nil)
            
        default: self = .unknown
        }
    }
}
