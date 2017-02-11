//
//  UICustomizationService.swift
//  WhoWorks
//
//  Created by Медведь Святослав on 07.02.17.
//  Copyright © 2017 loogle18. All rights reserved.
//

import UIKit

struct UICustomizationService {
    static func defaultTextFieldUI(_ textField: UITextField, placeholder: String) {
        let customDarkColor = UIColor(red: 28/255, green: 25/255, blue: 33/255, alpha: 1)
        textField.layer.cornerRadius = 4.0
        textField.layer.borderWidth = 1
        textField.layer.borderColor = customDarkColor.cgColor
        textField.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                             attributes:[NSForegroundColorAttributeName: customDarkColor])
    }
    
    static func errorTextFieldUI(_ textField: UITextField, fieldName: String) {
        let customRedColor = UIColor(red: 255/255, green: 104/255, blue: 104/255, alpha: 1)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = customRedColor.cgColor
        textField.attributedPlaceholder = NSAttributedString(string: "\(fieldName) is incorrect or empty",
                                                             attributes:[NSForegroundColorAttributeName: customRedColor])
    }
    
    static func defaultSearchTextFieldUI(_ textField: UITextField) {
        let customDarkColor = UIColor(red: 204/255, green: 204/255, blue: 216/255, alpha: 1)
        textField.layer.cornerRadius = 4.0
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder ?? "Search...",
                                                             attributes:[NSForegroundColorAttributeName: customDarkColor])
    }
}

