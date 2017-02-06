//
//  User.swift
//  WhoWorks
//
//  Created by Медведь Святослав on 05.02.17.
//  Copyright © 2017 loogle18. All rights reserved.
//

import Foundation

class User {
    var id, statusCode : Int
    var login, email : String
    var status, fullName, avatarUrl : String?
    
    init(id: Int, login: String, email: String) {
        self.id = id
        self.login = login
        self.email = email
        self.statusCode = 0
        self.status = ""
        self.fullName = ""
        self.avatarUrl = ""
    }
    
    init(id: Int, login: String, email: String, statusCode: Int, status: String?, fullName: String?, avatarUrl: String?) {
        self.id = id
        self.login = login
        self.email = email
        self.statusCode = statusCode
        self.status = status
        self.fullName = fullName
        self.avatarUrl = avatarUrl
    }
}
