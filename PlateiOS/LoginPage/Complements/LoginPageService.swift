//
//  LoginPageService.swift
//  PlateiOS
//
//  Created by Renner Leite Lucena on 12/1/17.
//  Copyright © 2017 Renner Leite Lucena. All rights reserved.
//

import Foundation
import Alamofire

final class LoginPageService {
    
    private let path = "https://plate-heroku-database.herokuapp.com/"
    
    func registerUser(username: String, completionRegisterUser: @escaping (_ success: Bool, _ username: String) -> Void) {
        Alamofire.request(path + "users/create/" + username, method: .get, parameters: nil).responseString { response in
            if let stringResponse = response.result.value {
                let success = (stringResponse == "true") // see this
                completionRegisterUser(success, username)
            }
        }
    }
    
    func checkUser(username: String, completionCheckUser: @escaping (_ success: Bool, _ username: String) -> Void) {
        Alamofire.request(path + "users/read/" + username, method: .get, parameters: nil).responseString { response in
            if let stringResponse = response.result.value {
                let success = (stringResponse == "true") // see this
                completionCheckUser(success, username)
            }
        }
    }
}
