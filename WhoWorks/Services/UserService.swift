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
    private class var indexUrl : String {
        return "http://192.168.0.103:3000/api/v1/users"
    }
    
    private class var authUrl : String {
        return "http://192.168.0.103:3000/api/v1/auth"
    }
    
    private class func createUserFromResponse(_ response: Dictionary<String, Any>) -> User {
        let user = User(
            id: response["id"] as! Int, login: response["login"] as! String, email: response["login"] as! String,
            statusCode: response["status_code"] as! Int, status: response["status"] as? String, fullName: response["full_name"] as? String, avatarUrl: response["avatar_url"] as? String
        )
        return user
    }
    
    class func getUsers() -> [User] {
        let response = Alamofire.request(indexUrl).responseJSON()
        
        var users = [User]()
        if let result = response.result.value {
            let data = result as! Array<Any>
            for item in data {
                let user = createUserFromResponse(item as! Dictionary<String, Any>)
                users.append(user)
            }
        }
        return users
    }
    
    class func createUser(_ parameters: [String : String]) -> Any {
        let params : [String : Any] = ["user" : parameters]
        let response = Alamofire.request(indexUrl, method: .post, parameters: params).responseJSON()
        var result : Any = 400
        
        if response.result.isSuccess {
            if let resp = response.response, resp.statusCode == 200  {
                result = createUserFromResponse(response.result.value as! Dictionary<String, Any>)
            } else if let resp = response.response, resp.statusCode == 406 {
                result = response.result.value as! Array<String>
            }
        }
        return result
    }
    
    class func authUser(_ parameters: [String]) -> Any {
        let params = ["user" : ["email" : parameters[0], "password" : parameters[1]]]
        let response = Alamofire.request(authUrl, method: .get, parameters: params).responseJSON()
        var result : Any = 400
        
        if response.result.isSuccess {
            result = createUserFromResponse(response.result.value as! Dictionary<String, Any>)
            
        } else if let resp = response.response {
            result = resp.statusCode
        }
        return result
    }
}
