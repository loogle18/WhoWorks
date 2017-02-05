//
//  UserService.swift
//  WhoWorks
//
//  Created by Медведь Святослав on 05.02.17.
//  Copyright © 2017 loogle18. All rights reserved.
//

import Foundation
import Alamofire

class UserService {
    private class var url:String {
        return "http://localhost:3000/api/v1/users"
    }
    
    class func getUsers() {
        Alamofire.request(self.url).responseJSON { response in
            print(response)
        }
    }
    
    class func postUser(params: [String:Any]) {
        Alamofire.request(self.url, method: .post, parameters: params, encoding: URLEncoding.default, headers: [:]).responseJSON { response in
                            print(response.result)
        }
    }
}
