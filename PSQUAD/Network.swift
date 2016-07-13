//
//  Reach.swift
//  PSQUAD
//
//  Created by James Taylor on 2016-07-12.
//  Copyright © 2016 James Taylor. All rights reserved.
//

import Foundation

import Alamofire

enum Network {
    
    /// 'Alamofire.Manager' for my local network that disables https evaluation
    static let local: Alamofire.Manager = {
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            "192.168.0.2": .DisableEvaluation
        ]
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.HTTPAdditionalHeaders = Alamofire.Manager.defaultHTTPHeaders
        
        return Alamofire.Manager(
            configuration: configuration,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
    }()
}