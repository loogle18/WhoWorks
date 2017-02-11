//
//  RegisterViewController.swift
//  WhoWorks
//
//  Created by Медведь Святослав on 08.02.17.
//  Copyright © 2017 loogle18. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var loginNameTextField : UITextField!
    @IBOutlet weak var emailTextField : UITextField!
    @IBOutlet weak var passwordTextField : UITextField!
    @IBOutlet weak var sumbitButton : UIButton!
    
    var createUserResponse : Any = 400
    var validation : Bool = false
    var users = [User]()
    let loginNamePlaceholder = "Login name"
    let emailPlaceholder = "Email"
    let passwordPlaceholder = "Password"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UICustomizationService.defaultTextFieldUI(loginNameTextField, placeholder: loginNamePlaceholder)
        UICustomizationService.defaultTextFieldUI(emailTextField, placeholder: emailPlaceholder)
        UICustomizationService.defaultTextFieldUI(passwordTextField, placeholder: passwordPlaceholder)
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
            createUserResponse = UserService.createUser(params)
            validation = ValidationService.postServerValidation(createUserResponse, controller: self)
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
