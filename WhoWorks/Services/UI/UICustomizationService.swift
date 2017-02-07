//
//  UICustomizationService.swift
//  WhoWorks
//
//  Created by Медведь Святослав on 07.02.17.
//  Copyright © 2017 loogle18. All rights reserved.
//

import UIKit

struct UICustomizationService {
    static func defaultTextFieldUI(_ textField: UITextField) {
        let customGrayColor = UIColor(red: 222/255, green: 222/255, blue: 222/255, alpha: 1)
        textField.layer.cornerRadius = 4.0
        textField.layer.borderWidth = 1
        textField.layer.borderColor = customGrayColor.cgColor
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder ?? "",
                                                             attributes:[NSForegroundColorAttributeName: customGrayColor])
    }
    
    static func errorTextFieldUI(_ textField: UITextField, fieldName: String) {
        let customRedColor = UIColor(red: 255/255, green: 104/255, blue: 104/255, alpha: 1)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = customRedColor.cgColor
        textField.attributedPlaceholder = NSAttributedString(string: "\(fieldName) is incorrect or empty",
                                                             attributes:[NSForegroundColorAttributeName: customRedColor])
    }
}

