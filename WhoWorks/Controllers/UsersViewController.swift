//
//  UsersViewController.swift
//  WhoWorks
//
//  Created by Медведь Святослав on 10.02.17.
//  Copyright © 2017 loogle18. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var offlineUsersCounter: UIButton!
    @IBOutlet weak var doNotDisturbUsersCounter: UIButton!
    @IBOutlet weak var activeUsersCounter: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var menuBarButton: UIBarButtonItem!
    
    var users = [User]()
    var allOriginUsers = [User]()
    var usersRefreshControl: UIRefreshControl!
    var offlineUsers = [User]()
    var doNotDisturbUsers = [User]()
    var activeUsers = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allOriginUsers = users
        initRevealVCLogic()
        initStatusCodeCountersUI()
        initStatusCodeCounters()
        UICustomizationService.defaultSearchTextFieldUI(searchTextField)
        refreshHandler()
        searchTextField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // TODO: Move to viewDidAppear and add spiner
        users = UserService.getUsers()
        allOriginUsers = users
        tableView.reloadData()
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserTableViewCell
        let user = users[indexPath.row]
        
        cell.circleColor = user.statusColor
        cell.loginName.text = user.login
        cell.status.text = user.status
        cell.avatarImageView.image = user.avatar
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowSelectedUser" {
            let userVC = segue.destination as? UserViewController
            guard let cell = sender as? UITableViewCell,
                let indexPath = tableView.indexPath(for: cell) else {
                    return
            }
            userVC?.user = users[indexPath.row]
        }
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
    
    @IBAction func searchUsers(_ sender: UITextField) {
        if let searchText = sender.text, ValidationService.checkPresence(searchText) {
            users = User.findAllByLogin(searchText, from: allOriginUsers)
        } else {
            users = allOriginUsers
        }
        tableView.reloadData()
    }
    
    @objc private func initRevealVCLogic() {
        if let revealVC = revealViewController() {
            menuBarButton.target = revealVC
            menuBarButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(revealVC.panGestureRecognizer())
        }
    }
    
    @objc private func initStatusCodeCountersUI() {
        offlineUsersCounter.layer.borderColor = UIColor.white.cgColor
        doNotDisturbUsersCounter.layer.borderColor = UIColor.white.cgColor
        activeUsersCounter.layer.borderColor = UIColor.white.cgColor
        
        offlineUsersCounter.layer.cornerRadius = 12.0
        doNotDisturbUsersCounter.layer.cornerRadius = 12.0
        activeUsersCounter.layer.cornerRadius = 12.0
    }
    
    @objc private func initStatusCodeCounters() {
        offlineUsers = User.findAllByStatusCode(0, from: users)
        doNotDisturbUsers = User.findAllByStatusCode(1, from: users)
        activeUsers = User.findAllByStatusCode(2, from: users)
        
        offlineUsersCounter.setTitle(String(offlineUsers.count), for: .normal)
        doNotDisturbUsersCounter.setTitle(String(doNotDisturbUsers.count), for: .normal)
        activeUsersCounter.setTitle(String(activeUsers.count), for: .normal)
    }
    
    @objc private func filterUsersByStatusCode(_ sender: UIButton, code: Int) {
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
        usersRefreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh",
                                                                 attributes:[NSForegroundColorAttributeName: UIColor.white])
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
