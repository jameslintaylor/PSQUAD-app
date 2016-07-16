//
//  UsersTableViewModel.swift
//  PSQUAD
//
//  Created by James Taylor on 2016-07-15.
//  Copyright © 2016 James Taylor. All rights reserved.
//

import Foundation

import RxSwift
import RxDataSources

struct UsersTableViewModel {
    
    let dataSource = RxTableViewSectionedReloadDataSource<SectionOfUsers>().with {
        
        $0.configureCell = { _, tableView, indexPath, user in
            let cell = tableView.dequeueReusableCellWithIdentifier("UserCell", forIndexPath: indexPath) as! UserCell
            cell.user = user
            return cell
        }
    }
    
    /// Splits an array of users into sections based on their online presence.
    func section(users: [User]) -> [SectionOfUsers] {
        
        var online = [User]()
        var offline = [User]()
        var unknown = [User]()
        
        for user in users {
            
            switch user.presence {
            case .online: online.append(user)
            case .offline: offline.append(user)
            case .unknown: unknown.append(user)
            }
        }
        
        return [
            SectionOfUsers(items: online),
            SectionOfUsers(items: offline),
            SectionOfUsers(items: unknown)
        ].filter { !$0.items.isEmpty } // Don't need empty sections
    }
}
