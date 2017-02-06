//
//  UserService.swift
//  WhoWorks
//
//  Created by Медведь Святослав on 05.02.17.
//  Copyright © 2017 loogle18. All rights reserved.
//

import Foundation
import Alamofire
import Alamofire_Synchronous

class UserService {
    private class var url : String {
        return "http://localhost:3000/api/v1/users"
    }
    
    class func getUsers() -> [User] {
        let response = Alamofire.request(self.url).responseJSON()
        
        var users = [User]()
        if let result = response.result.value {
            let data = result as! Array<Any>
            for item in data {
                var u = item as! Dictionary<String, Any>
                let user = User(
                    id: u["id"] as! Int, login: u["login"] as! String, email: u["login"] as! String,
                    statusCode: u["status_code"] as! Int, status: u["status"] as? String, fullName: u["full_name"] as? String, avatarUrl: u["avatar_url"] as? String
                )
                users.append(user)
            }
        }
        return users
    }
    
    class func postUser(_ parameters: [String : Any]) {
        let params : [String : Any] = ["user" : parameters]
        Alamofire.request(self.url, method: .post, parameters: params, encoding: URLEncoding.default, headers: [:]).responseJSON { response in
                            print(response.result)
        }
    }
}
