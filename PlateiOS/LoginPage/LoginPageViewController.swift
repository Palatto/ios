//
//  LoginPageViewController.swift
//  PlateiOS
//
//  Created by Renner Leite Lucena on 11/28/17.
//  Copyright © 2017 Renner Leite Lucena. All rights reserved.
//

import UIKit

class LoginPageViewController: UIViewController {
    
    @IBOutlet weak var constraintOffset: NSLayoutConstraint!
    
    @IBOutlet weak var logoImage: UIImageView! {
        didSet {
            logoImage.tintColor = PlateColors.mainRed
            logoImage.backgroundColor = PlateColors.mainRed
        }
    }
    
    @IBOutlet weak var usernameInput: UITextField! {
        didSet {
            let imageView = UIImageView(frame: CGRect(x: 10, y: 0, width: 20, height: 20))
            imageView.image = #imageLiteral(resourceName: "usernameIcon")
            let contentView = UIView(frame: CGRect(x: 10, y: 0, width: 30, height: 20))
            contentView.addSubview(imageView)
            
            usernameInput.delegate = self
            usernameInput.leftViewMode = UITextFieldViewMode.always
            usernameInput.leftView = contentView
            usernameInput.placeholder = "Username"
        }
    }
    
    @IBOutlet weak var signupButton: UIButton! {
        didSet {
            signupButton.layer.cornerRadius = 5
            signupButton.layer.borderWidth = 2
            signupButton.layer.borderColor = PlateColors.mainBlue.cgColor
        }
    }
    
    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            loginButton.layer.cornerRadius = 5
            loginButton.layer.borderWidth = 2
            loginButton.layer.borderColor = PlateColors.mainWhite.cgColor
        }
    }
    
    @IBAction func signupButtonAction(_ sender: Any) {
        loginPageController.tryToSignup(username: usernameInput.text ?? "")
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        loginPageController.tryToLogin(username: usernameInput.text ?? "")
    }
    
    fileprivate lazy var loginPageController: LoginPageController = {
        return LoginPageController(loginPageProtocol: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
}

extension LoginPageViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension LoginPageViewController: LoginPageProtocol {
    
    func showErrorMessage(title : String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
    
    func openViewController(controller: UIViewController) {
        DispatchQueue.main.async {
            self.show(controller, sender: nil)
        }
    }
    
    func presentViewController(controller: UIViewController) {
        DispatchQueue.main.async {
            self.present(controller, animated: true, completion: nil)
        }
    }
}

extension LoginPageViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(usernameInput == textField) {
            constraintOffset.constant = -200
            self.view.layoutIfNeeded()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= 18
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        constraintOffset.constant = -140
        self.view.layoutIfNeeded()
    }
}


