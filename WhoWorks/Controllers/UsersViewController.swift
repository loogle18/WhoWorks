//
//  UsersViewController.swift
//  WhoWorks
//
//  Created by Медведь Святослав on 10.02.17.
//  Copyright © 2017 loogle18. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var offlineUsersCounter: UIButton!
    @IBOutlet weak var doNotDisturbUsersCounter: UIButton!
    @IBOutlet weak var activeUsersCounter: UIButton!
    
    var users = [User]()
    var allOriginUsers = [User]()
    var usersRefreshControl: UIRefreshControl!
    var offlineUsers = [User]()
    var doNotDisturbUsers = [User]()
    var activeUsers = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allOriginUsers = users
        initStatusCodeCountersUI()
        initStatusCodeCounters()
        refreshHandler()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserTableViewCell
        let user = users[indexPath.row]
        
        cell.statusCircle.backgroundColor = user.statusColor
        cell.loginName.text = user.login
        cell.status.text = user.status
        return cell
    }
    
    @IBAction func showOnlyOfflineUsers(_ sender: UIButton) {
        filterUsersByStatusCode(sender, code: 0)
    }
    
    @IBAction func showOnlyDoNotDisturbUsers(_ sender: UIButton) {
        filterUsersByStatusCode(sender, code: 1)
    }
    
    @IBAction func showOnlyActiveUsers(_ sender: UIButton) {
        filterUsersByStatusCode(sender, code: 2)
    }
    
    @objc private func initStatusCodeCountersUI() {
        offlineUsersCounter.layer.borderColor = UIColor.gray.cgColor
        doNotDisturbUsersCounter.layer.borderColor = UIColor.gray.cgColor
        activeUsersCounter.layer.borderColor = UIColor.gray.cgColor
        
        offlineUsersCounter.layer.cornerRadius = 12.0
        doNotDisturbUsersCounter.layer.cornerRadius = 12.0
        activeUsersCounter.layer.cornerRadius = 12.0
    }
    
    @objc private func initStatusCodeCounters() {
        offlineUsers = User.getAllByStatusCode(0, from: users)
        doNotDisturbUsers = User.getAllByStatusCode(1, from: users)
        activeUsers = User.getAllByStatusCode(2, from: users)
        
        offlineUsersCounter.setTitle(String(offlineUsers.count), for: .normal)
        doNotDisturbUsersCounter.setTitle(String(doNotDisturbUsers.count), for: .normal)
        activeUsersCounter.setTitle(String(activeUsers.count), for: .normal)
    }
    
    @objc func filterUsersByStatusCode(_ sender: UIButton, code: Int) {
        let usersDictionary = [offlineUsers, doNotDisturbUsers, activeUsers]
        if sender.layer.borderWidth != 0 {
            resetHighlightedStyleForCounters()
            users = allOriginUsers
        } else {
            resetHighlightedStyleForCounters()
            sender.layer.borderWidth = 1.5
            users = usersDictionary[code]
        }
        tableView.reloadData()
    }
    
    @objc private func resetHighlightedStyleForCounters() {
        offlineUsersCounter.layer.borderWidth = 0
        doNotDisturbUsersCounter.layer.borderWidth = 0
        activeUsersCounter.layer.borderWidth = 0
    }
    
    @objc private func refreshHandler() {
        usersRefreshControl = UIRefreshControl()
        usersRefreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        usersRefreshControl.addTarget(self, action: #selector(self.refresh), for: UIControlEvents.valueChanged)
        tableView.addSubview(usersRefreshControl)
    }
    
    @objc private func refresh(sender: AnyObject) {
        users = UserService.getUsers()
        allOriginUsers = users
        tableView.reloadData()
        initStatusCodeCounters()
        usersRefreshControl.endRefreshing()
    }
}
