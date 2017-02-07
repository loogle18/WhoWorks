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
    @IBOutlet weak var emailTextField : UITextField!
    @IBOutlet weak var passwordTextField : UITextField!
    @IBOutlet weak var enterButton : UIButton!
    
    var users = [User]()
    var authUserResponse : Any = 400
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.users = UserService.getUsers()
        UICustomizationService.defaultTextFieldUI(emailTextField)
        UICustomizationService.defaultTextFieldUI(passwordTextField)
    }
    
    @IBAction func onFocusTextField(_ sender: UITextField) {
        UICustomizationService.defaultTextFieldUI(sender)
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        let (email, password) = (emailTextField!, passwordTextField!)
        let frontEmailValid = ValidationService.frontValidation(email, fieldName: "Email")
        let frontPasswordValid = ValidationService.frontValidation(password, fieldName: "Password")
        
        if frontEmailValid && frontPasswordValid {
            let params = [email.text!, password.text!]
            self.authUserResponse = UserService.authUser(params)
            let validation = ValidationService.serverValidation(authUserResponse, controller: self)
            print("validation: \(validation)")
        }
        print(authUserResponse)
    }
}
