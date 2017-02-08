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
    var validation : Bool = false
    let emailPlaceholder = "Email"
    let passwordPlaceholder = "Password"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.users = UserService.getUsers()
        UICustomizationService.defaultTextFieldUI(emailTextField, placeholder: emailPlaceholder)
        UICustomizationService.defaultTextFieldUI(passwordTextField, placeholder: passwordPlaceholder)
    }
    
    @IBAction func onFocusTextField(_ sender: UITextField) {
        let placeholder = sender == emailTextField ? emailPlaceholder : passwordPlaceholder
        UICustomizationService.defaultTextFieldUI(sender, placeholder: placeholder)
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        let frontEmailValid = ValidationService.frontValidation(emailTextField, fieldName: emailPlaceholder)
        let frontPasswordValid = ValidationService.frontValidation(passwordTextField, fieldName: passwordPlaceholder)
        
        if frontEmailValid && frontPasswordValid {
            let params = [emailTextField.text!, passwordTextField.text!]
            self.authUserResponse = UserService.authUser(params)
            validation = ValidationService.authServerValidation(authUserResponse, controller: self)
        }
        print(validation)
    }
}
