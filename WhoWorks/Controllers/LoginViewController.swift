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
    
    var authUserResponse : Any = 400
    var validation : Bool = false
    var users = [User]()
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
        
        if validation {
            self.users = UserService.getUsers()
            let usersStoryboard = UIStoryboard(name: "Users", bundle: nil)
            let controller = usersStoryboard.instantiateViewController(withIdentifier: "UsersView")
            if let usersVC = controller as? UsersViewController {
                usersVC.users = users
            }
            self.present(controller, animated: true, completion: nil)
        }
    }
}
