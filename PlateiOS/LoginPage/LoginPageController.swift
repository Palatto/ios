//
//  LoginPageController.swift
//  PlateiOS
//
//  Created by Renner Leite Lucena on 11/28/17.
//  Copyright © 2017 Renner Leite Lucena. All rights reserved.
//

import UIKit

final class LoginPageController {
    
    private let loginPageService: LoginPageService = LoginPageService()
    private unowned let loginPageProtocol: LoginPageProtocol
    
    init(loginPageProtocol: LoginPageProtocol) {
        self.loginPageProtocol = loginPageProtocol
    }
}

extension LoginPageController {
    
    func tryToSignup(username: String) {
        let pattern = "^[-_+.a-zA-Z0-9!@#$%^*()]{1,18}$"
        let matcher = NSPredicate(format:"SELF MATCHES[c] %@", pattern)
        
        if(!matcher.evaluate(with: username)) {
            loginPageProtocol.showErrorMessage(title: "Error", message: "Invalid username entered. Please, try again.")
            return
        }
        
        loginPageService.registerUser(username: username, completionRegisterUser: { [weak self] success, username in
            self?.handleRegisterUser(success: success, username: username)
        })
    }
    
    func tryToLogin(username: String) {
        let pattern = "^[-_+.a-zA-Z0-9!@#$%^*()]{1,18}$"
        let matcher = NSPredicate(format:"SELF MATCHES[c] %@", pattern)
        
        if(!matcher.evaluate(with: username)) {
            loginPageProtocol.showErrorMessage(title: "Error", message: "Invalid username entered. Please, try again.")
            return
        }
        
        loginPageService.checkUser(username: username, completionCheckUser: { [weak self] success, username in
            self?.handleCheckUser(success: success, username: username)
        })
    }
}

extension LoginPageController {
    
    fileprivate func handleRegisterUser(success: Bool, username: String) {
        if(success == true) {
<<<<<<< HEAD
=======
            
>>>>>>> e6c15bc344cec5dc89a88e670055819b19d45526
            let defaults = UserDefaults.standard
            defaults.set(true, forKey: "isLoggedIn")
            defaults.set(username, forKey: "username")
            
            let promotionListViewController = UIStoryboard.init(name: "PromotionList", bundle: nil).instantiateViewController(withIdentifier: "PromotionList")
                as! PromotionListViewController
            promotionListViewController.username = username
            loginPageProtocol.openViewController(controller: promotionListViewController)
        }
        else {
            loginPageProtocol.showErrorMessage(title: "Error", message: "Username already exists. Please, try again.")
        }
    }
    
    fileprivate func handleCheckUser(success: Bool, username: String) {
        if(success == true) {
            let defaults = UserDefaults.standard
            defaults.set(true, forKey: "isLoggedIn")
            defaults.set(username, forKey: "username")
            
            let promotionListViewController = UIStoryboard.init(name: "PromotionList", bundle: nil).instantiateViewController(withIdentifier: "PromotionList")
                as! PromotionListViewController
            promotionListViewController.username = username
            loginPageProtocol.openViewController(controller: promotionListViewController)
        }
        else {
            loginPageProtocol.showErrorMessage(title: "Error", message: "Username does not exist. Please, try again.")
        }
    }
}
