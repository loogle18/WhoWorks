//
//  ValidationService.swift
//  WhoWorks
//
//  Created by Медведь Святослав on 07.02.17.
//  Copyright © 2017 loogle18. All rights reserved.
//

import UIKit

struct ValidationService {
    private static func checkPresence(_ textFieldText: String?) -> Bool {
        return !(textFieldText ?? "").isEmpty
    }
    
    private static func showAlert(_ controller: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        controller.present(alert, animated: true, completion: nil)
    }
    
    static func frontValidation(_ textField: UITextField, fieldName: String) -> Bool {
        let textFieldText : String? = textField.text
        if checkPresence(textFieldText) {
            switch fieldName {
                case "Email" where textFieldText!.range(of: "@") != nil:
                    return true
                case "Email" where textFieldText!.range(of: "@") == nil:
                    UICustomizationService.errorTextFieldUI(textField, fieldName: fieldName)
                    return false
                default:
                    return true
            }
        } else {
            UICustomizationService.errorTextFieldUI(textField, fieldName: fieldName)
            return false
        }
    }
    
    static func serverValidation(_ response: Any, controller: UIViewController) -> Bool {
        switch response {
            case let code as Int where code == 400:
                showAlert(controller, title: "Bad request", message: "Something went wrong!")
                return false
            case let code as Int where code == 401:
                showAlert(controller, title: "Bad credentials", message: "Wrong password!")
                return false
            case let code as Int where code == 404:
                showAlert(controller, title: "Bad credentials", message: "No user with such email!")
                return false
            case is User:
                return true
            default:
                return false
        }
    }
}
