//
//  LoginViewController.swift
//  WhoWorks
//
//  Created by Медведь Святослав on 30.01.17.
//  Copyright © 2017 loogle18. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import Alamofire_Synchronous

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var enterButton: UIButton!
    
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.users = UserService.getUsers()
        print(self.users)
    }
    
    @IBAction func loginAction(_ sender: Any) {
//        let params : [String:Any] = [
//            "email": emailTextField ?? "",
//            "password": passwordTextField.text ?? ""
//        ]
//        
//        UserService.postUser(params)
    }
}
