//
//  LoginPageViewController.swift
//  PlateiOS
//
//  Created by Renner Leite Lucena on 11/28/17.
//  Copyright © 2017 Renner Leite Lucena. All rights reserved.
//

import UIKit

class LoginPageViewController: UIViewController {
    
    @IBOutlet weak var username_input: UITextField!
    @IBAction func signup_button_action(_ sender: Any) {
        loginPageController.tryToSignup(username: username_input.text ?? "")
    }
    @IBAction func login_button_action(_ sender: Any) {
        loginPageController.tryToLogin(username: username_input.text ?? "")
    }
    
    fileprivate lazy var loginPageController: LoginPageController = {
        return LoginPageController(loginPageProtocol: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension LoginPageViewController: LoginPageProtocol {
    func showErrorMessage(message: String) {
        
    }
    
    func showAlert() {
        
    }
    
    func setItemsList(promotions: [PromotionModel]) {
        
    }
    
}

