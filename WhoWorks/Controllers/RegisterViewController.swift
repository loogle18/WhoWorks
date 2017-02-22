//
//  RegisterViewController.swift
//  WhoWorks
//
//  Created by Медведь Святослав on 08.02.17.
//  Copyright © 2017 loogle18. All rights reserved.
//

import UIKit
import SWRevealViewController

class RegisterViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var loginNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var sumbitButton: UIButton!
    
    var createUserResponse: Any = 400
    var validation: Bool = false
    var users = [User]()
    let loginNamePlaceholder = "Login name"
    let emailPlaceholder = "Email"
    let passwordPlaceholder = "Password"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sumbitButton.layer.cornerRadius = 4.0
        UICustomizationService.defaultTextFieldUI(loginNameTextField, placeholder: loginNamePlaceholder)
        UICustomizationService.defaultTextFieldUI(emailTextField, placeholder: emailPlaceholder)
        UICustomizationService.defaultTextFieldUI(passwordTextField, placeholder: passwordPlaceholder)
        loginNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {        
        switch textField {
            case loginNameTextField:
                emailTextField.becomeFirstResponder()
            case emailTextField:
                passwordTextField.becomeFirstResponder()
            default:
                passwordTextField.resignFirstResponder()
        }
        return true
    }
    
    @IBAction func onFocusTextField(_ sender: UITextField) {
        var placeholder : String!
        switch sender {
            case loginNameTextField:
                placeholder = loginNamePlaceholder
            case emailTextField:
                placeholder = emailPlaceholder
            case passwordTextField:
                placeholder = passwordPlaceholder
            default:
                placeholder = sender.placeholder
        }
        UICustomizationService.defaultTextFieldUI(sender, placeholder: placeholder)
    }
    
    @IBAction func submitAction(_ sender: UIButton) {
        let frontLoginNameValid = ValidationService.frontValidation(loginNameTextField, fieldName: loginNamePlaceholder)
        let frontEmailValid = ValidationService.frontValidation(emailTextField, fieldName: emailPlaceholder)
        let frontPasswordValid = ValidationService.frontValidation(passwordTextField, fieldName: passwordPlaceholder)
        
        if frontLoginNameValid && frontEmailValid && frontPasswordValid {
            let params = [
                "login" : loginNameTextField.text!,
                "email" : emailTextField.text!,
                "password" : passwordTextField.text!,
                "status_code" : "2"
            ]
            self.createUserResponse = UserService.createUser(params)
            validation = ValidationService.postServerValidation(createUserResponse, controller: self)
        }
        
        if validation {
            let usersStoryboard = UIStoryboard(name: "Users", bundle: nil)
            let SWRevealVC = usersStoryboard.instantiateViewController(withIdentifier: "SWRevealVC") as! SWRevealViewController
            let userVC = usersStoryboard.instantiateViewController(withIdentifier: "UsersView") as! UsersViewController
            let userMenuVC = usersStoryboard.instantiateViewController(withIdentifier: "UserMenuView") as! CurrentUserMenuViewController
            
            SWRevealVC.frontViewController = userVC
            SWRevealVC.rearViewController = userMenuVC
            userVC.users = UserService.getUsers()
            userMenuVC.currentUser = createUserResponse as? User
            
            self.present(SWRevealVC, animated: true, completion: nil)
        }
    }
}
