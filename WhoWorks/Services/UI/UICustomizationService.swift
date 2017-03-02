//
//  UICustomizationService.swift
//  WhoWorks
//
//  Created by Медведь Святослав on 07.02.17.
//  Copyright © 2017 loogle18. All rights reserved.
//

import UIKit
import JVFloatLabeledTextField

struct UICustomizationService {
    static func defaultTextFieldUI(_ textField: UITextField, placeholder: String) {
        let customGrayColor = UIColor.customGray()
        initBorderFor(textField, withColor: customGrayColor)
        textField.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                             attributes:[NSForegroundColorAttributeName: customGrayColor])
    }
    
    static func errorTextFieldUI(_ textField: UITextField, fieldName: String) {
        let customRedColor = UIColor.customRed()
        initBorderFor(textField, withColor: customRedColor)
        textField.attributedPlaceholder = NSAttributedString(string: "\(fieldName) is incorrect or empty",
                                                             attributes:[NSForegroundColorAttributeName: customRedColor])
    }
    
    static func searchTextField(_ textField: UITextField, placeholder: String = "Find team members...") {
        textField.textColor = UIColor.white
        textField.attributedPlaceholder = NSAttributedString(string: placeholder,
            attributes:[NSForegroundColorAttributeName: UIColor.customSecondaryBlack()])
    }
    
    private static func initBorderFor(_ textField: UITextField, withColor: UIColor) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: textField.frame.height - 1, width: textField.frame.width, height: 1.0)
        bottomLine.backgroundColor = withColor.cgColor
        textField.borderStyle = UITextBorderStyle.none
        textField.layer.addSublayer(bottomLine)
        textField.textColor = UIColor.customBlack()
    }
}

