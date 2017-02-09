//
//  UsersTableViewController.swift
//  WhoWorks
//
//  Created by Медведь Святослав on 08.02.17.
//  Copyright © 2017 loogle18. All rights reserved.
//

import UIKit

class UsersTableViewController: UITableViewController {
    var users = [User]()
    var usersRefreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshHandler()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserTableViewCell
        let user = users[indexPath.row]
        
        cell.statusCircle.backgroundColor = user.statusColor
        cell.loginName.text = user.login
        cell.status.text = user.status
        return cell
    }
    
    @objc private func refreshHandler() {
        usersRefreshControl = UIRefreshControl()
        usersRefreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        usersRefreshControl.addTarget(self, action: #selector(self.refresh), for: UIControlEvents.valueChanged)
        tableView.addSubview(usersRefreshControl)
    }
    
    @objc private func refresh(sender: AnyObject) {
        self.users = UserService.getUsers()
        self.tableView.reloadData()
        usersRefreshControl.endRefreshing()
    }
}
