//
//  User.swift
//  WhoWorks
//
//  Created by Медведь Святослав on 05.02.17.
//  Copyright © 2017 loogle18. All rights reserved.
//

import UIKit
import Foundation

class User {
    var id : Int
    var login, email : String
    var status, fullName, avatarUrl : String?
    var statusCode = 2 {
        willSet {
            statusColor = getStatusColorByCode(newValue)
        }
    }
    
    var statusColor : UIColor {
        get {
            return getStatusColorByCode(statusCode)
        }
        set {
           
        }
    }
    
    init(id: Int, login: String, email: String) {
        self.id = id
        self.login = login
        self.email = email
        self.status = ""
        self.fullName = ""
        self.avatarUrl = ""
        
        self.status = getStatusByCode(statusCode)
    }
    
    init(id: Int, login: String, email: String, statusCode: Int, status: String?, fullName: String?, avatarUrl: String?) {
        self.id = id
        self.login = login
        self.email = email
        self.statusCode = statusCode
        self.status = status
        self.fullName = fullName
        self.avatarUrl = avatarUrl
        
        if !ValidationService.checkPresence(status) {
            self.status = getStatusByCode(statusCode)
        }
    }
    
    @objc private func getStatusByCode(_ statusCode: Int) -> String {
        switch statusCode {
            case 0:
                return "Offline"
            case 1:
                return "Do not disturb"
            case 2:
                return "Active"
            default:
                return "Active"
        }
    }
    
    @objc private func getStatusColorByCode(_ statusCode: Int) -> UIColor {
        switch statusCode {
            case 0:
                return UIColor(red: 255/255, green: 104/255, blue: 104/255, alpha: 1)
            case 1:
                return UIColor(red: 255/255, green: 190/255, blue: 0/255, alpha: 1)
            case 2:
                return UIColor(red: 34/255, green: 191/255, blue: 135/255, alpha: 1)
            default:
                return UIColor(red: 34/255, green: 191/255, blue: 135/255, alpha: 1)
        }
    }
}
