//
//  UserCell.swift
//  PSQUAD
//
//  Created by James Taylor on 2016-07-13.
//  Copyright © 2016 James Taylor. All rights reserved.
//

import Foundation
import UIKit

class UserCell: UITableViewCell {
    
    @IBOutlet private weak var nameLabel: UILabel!
    
    var user: User? {
        didSet {
            guard let user = user else { return }
            configureFor(user: user)
        }
    }
    
    private func configureFor(user user: User) {
        
        nameLabel.text = user.id.uppercaseString
        nameLabel.alpha = user.isOnline ? 1.0 : 0.4
    }
}
