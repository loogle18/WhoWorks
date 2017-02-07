//
//  RegisterViewController.swift
//  WhoWorks
//
//  Created by Медведь Святослав on 08.02.17.
//  Copyright © 2017 loogle18. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var userNameTextField : UITextField!
    @IBOutlet weak var emailTextField : UITextField!
    @IBOutlet weak var passwordTextField : UITextField!
    @IBOutlet weak var sumbitButton : UIButton!
    
    var createUserResponse : Any = 400
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UICustomizationService.defaultTextFieldUI(userNameTextField)
        UICustomizationService.defaultTextFieldUI(emailTextField)
        UICustomizationService.defaultTextFieldUI(passwordTextField)
    }
    
    @IBAction func onFocusTextField(_ sender: UITextField) {
        UICustomizationService.defaultTextFieldUI(sender)
    }
    
    @IBAction func submitAction(_ sender: UIButton) {
        let (userName, email, password) = (userNameTextField!, emailTextField!, passwordTextField!)
        let frontUserNameValid = ValidationService.frontValidation(userName, fieldName: "User name")
        let frontEmailValid = ValidationService.frontValidation(email, fieldName: "Email")
        let frontPasswordValid = ValidationService.frontValidation(password, fieldName: "Password")
        
        if frontUserNameValid && frontEmailValid && frontPasswordValid {
            
        }
    }
}
