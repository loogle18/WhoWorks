//
//  LoginViewController.swift
//  WhoWorks
//
//  Created by Медведь Святослав on 30.01.17.
//  Copyright © 2017 loogle18. All rights reserved.
//

import UIKit
import Foundation

class LoginViewController: UIViewController {
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var enterButton: UIButton!
    var parameters : [String:Any] = [
        "user": [
            "email": "logan@w.com",
            "login": "logan19",
            "password": "password",
            "status_code": 0
        ]
    ]
    
    override func viewDidLoad() {
        UserService.getUsers()
    
    }
    
    @IBAction func loginAction(_ sender: Any) {
        UserService.postUser(params: parameters)
    }
}
