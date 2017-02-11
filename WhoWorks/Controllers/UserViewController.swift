//
//  UserViewController.swift
//  WhoWorks
//
//  Created by Медведь Святослав on 11.02.17.
//  Copyright © 2017 loogle18. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    @IBOutlet weak var userLogin: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userStatus: UILabel!
    
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        userLogin.text = user?.login
        userEmail.text = user?.email
        userStatus.text = user?.status
    }
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
