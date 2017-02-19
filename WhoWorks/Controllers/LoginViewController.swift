//
//  LoginViewController.swift
//  WhoWorks
//
//  Created by Медведь Святослав on 30.01.17.
//  Copyright © 2017 loogle18. All rights reserved.
//

import UIKit
import Foundation
import SWRevealViewController

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var enterButton: UIButton!
    
    var authUserResponse: Any = 400
    var validation: Bool = false
    let emailPlaceholder = "Email"
    let passwordPlaceholder = "Password"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UICustomizationService.defaultTextFieldUI(emailTextField, placeholder: emailPlaceholder)
        UICustomizationService.defaultTextFieldUI(passwordTextField, placeholder: passwordPlaceholder)
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField === emailTextField) {
            passwordTextField.becomeFirstResponder()
        } else if (textField === passwordTextField) {
            passwordTextField.resignFirstResponder()
        }
        return true
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
            let usersStoryboard = UIStoryboard(name: "Users", bundle: nil)
            let SWRevealVC = usersStoryboard.instantiateViewController(withIdentifier: "SWRevealVC") as! SWRevealViewController
            let userVC = usersStoryboard.instantiateViewController(withIdentifier: "UsersView") as! UsersViewController
            let userMenuVC = usersStoryboard.instantiateViewController(withIdentifier: "UserMenuView") as! CurrentUserMenuViewController
            
            SWRevealVC.frontViewController = userVC
            SWRevealVC.rearViewController = userMenuVC
            userVC.users = UserService.getUsers()
            userMenuVC.currentUser = authUserResponse as? User
            
            self.present(SWRevealVC, animated: true, completion: nil)
        }
    }
}
