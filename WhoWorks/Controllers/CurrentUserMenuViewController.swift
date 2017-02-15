//
//  CurrentUserMenuViewController.swift
//  WhoWorks
//
//  Created by Медведь Святослав on 15.02.17.
//  Copyright © 2017 loogle18. All rights reserved.
//

import UIKit

class CurrentUserMenuViewController: UIViewController {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userLogin: UILabel!
    
    var currentUser: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        avatarImageView.image = currentUser?.avatar
        avatarImageView.layer.cornerRadius = 120.0
        userEmail.text = currentUser?.email
        userLogin.text = currentUser?.login
    }
}
