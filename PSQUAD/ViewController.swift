//
//  ViewController.swift
//  PSQUAD
//
//  Created by James Taylor on 2016-07-11.
//  Copyright © 2016 James Taylor. All rights reserved.
//

import UIKit

import RxMoya
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet private weak var searchField: UITextField!
    @IBOutlet private weak var usersTable: UITableView!
    
    private let psn = PSNModel(provider: RxMoyaProvider(manager: .local))
    private let usersTableModel = UsersTableViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRx()
    }
    
    private func setupRx() {
        
        let searchText = searchField.rx_text
            .throttle(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
        
        let friends = psn.trackFriends(of: searchText)
        let friendsWithPresences = psn.trackPresences(of: friends)

        Observable.of(friends, friendsWithPresences).merge()
            .map(usersTableModel.section)
            .bindTo(usersTable.rx_itemsWithDataSource(usersTableModel.dataSource))
            .addDisposableTo(disposeBag)
        
        usersTable.rx_setDelegate(self)
            .addDisposableTo(disposeBag)
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
}
