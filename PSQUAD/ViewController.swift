//
//  ViewController.swift
//  PSQUAD
//
//  Created by James Taylor on 2016-07-11.
//  Copyright © 2016 James Taylor. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FriendListRequest(of: "JiBBsTeRR").get { result in
            print(result.value)
        }
    }
}
