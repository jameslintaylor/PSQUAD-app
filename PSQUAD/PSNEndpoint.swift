//
//  PSNEndpoint.swift
//  PSQUAD
//
//  Created by James Taylor on 2016-07-13.
//  Copyright © 2016 James Taylor. All rights reserved.
//

import Foundation

import RxMoya

enum PSN {
    
    case profile(of: String)
    case friends(of: String)
    case presence(of: String)
}

extension PSN: TargetType {
    
    var baseURL: NSURL { return NSURL(string: "https://192.168.2.2/api/psn")! }
    
    var path: String {
        
        switch self {
            
        case .profile:
            return "/profileOf"
            
        case .friends:
            return "/friendsOf"
            
        case .presence:
            return "/presenceOf"
        }
    }
    
    var method: RxMoya.Method { return .GET }
    
    var parameters: [String : AnyObject]? {
        
        switch self {
            
        case .profile(let id):
            return ["id": id.URLEscapedString]
            
        case .friends(let id):
            return ["id": id.URLEscapedString]
            
        case .presence(let id):
            return ["id": id.URLEscapedString]
        }
    }
    
    var sampleData: NSData {
        
        switch self {
            
        case .profile:
            return "{\"onlineId\":\"JiBBsTeRR\",\"region\":\"ca\",\"npId\":\"SmlCQnNUZVJSQGM5LmNh\",\"avatarUrl\":\"http://static-resource.np.community.playstation.net/avatar/WWS_E/E0009.png\",\"aboutMe\":\"\",\"languagesUsed\":[\"en\"],\"plus\":1,\"trophySummary\":{\"level\":3,\"progress\":77,\"earnedTrophies\":{\"platinum\":0,\"gold\":1,\"silver\":7,\"bronze\":51}},\"relation\":\"me\",\"presence\":{\"primaryInfo\":{\"onlineStatus\":\"offline\",\"lastOnlineDate\":\"2016-07-13T06:14:23Z\"}},\"personalDetail\":{\"firstName\":\"James\",\"lastName\":\"Taylor\"},\"usePersonalDetailInGame\":false}".dataUsingEncoding(NSUTF8StringEncoding)!
            
        case .friends:
            return "[{\"onlineId\":\"callmekaito\",\"region\":\"ca\",\"npId\":\"Y2FsbG1la2FpdG9AZDQuY2E=\",\"avatarUrl\":\"http://psn-rsc.prod.dl.playstation.net/psn-rsc/avatar/UP4396/CUSA04449_00-AV00000000000019_030AA0AE56A06C0D5F21_l.png\",\"plus\":1,\"trophySummary\":{\"level\":3,\"progress\":82,\"earnedTrophies\":{\"platinum\":0,\"gold\":1,\"silver\":11,\"bronze\":45}},\"relation\":\"friend\",\"personalDetailSharing\":\"shared\",\"personalDetail\":{\"firstName\":\"Kevin\",\"lastName\":\"Brice\"}},{\"onlineId\":\"educky\",\"region\":\"ca\",\"npId\":\"ZWR1Y2t5QGM3LmNh\",\"avatarUrl\":\"http://psn-rsc.prod.dl.playstation.net/psn-rsc/avatar/UP9000/CUSA03018_00-AV00000000000003_757F40383085F6650883_l.png\",\"plus\":1,\"trophySummary\":{\"level\":10,\"progress\":58,\"earnedTrophies\":{\"platinum\":0,\"gold\":25,\"silver\":127,\"bronze\":474}},\"relation\":\"friend\"}}]".dataUsingEncoding(NSUTF8StringEncoding)!
            
        case .presence:
            return "{\"primaryInfo\":{\"onlineStatus\":\"offline\",\"lastOnlineDate\":\"2016-07-13T06:14:23Z\"}}".dataUsingEncoding(NSUTF8StringEncoding)!
            
        }
        
    }
}

// Helpers

private extension String {
    var URLEscapedString: String {
        return self.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())!
    }
}
