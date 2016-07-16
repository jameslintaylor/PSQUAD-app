//
//  SectionOfUsers.swift
//  PSQUAD
//
//  Created by James Taylor on 2016-07-15.
//  Copyright © 2016 James Taylor. All rights reserved.
//

import Foundation

import RxDataSources

struct SectionOfUsers {
    
    let items: [Item]
}

extension SectionOfUsers: SectionModelType {
    
    typealias Item = User
    
    init(original: SectionOfUsers, items: [Item]) {
        self.items = items
    }
}

extension SectionOfUsers: CustomStringConvertible {
    var description: String {
        return String(items)
    }
}
