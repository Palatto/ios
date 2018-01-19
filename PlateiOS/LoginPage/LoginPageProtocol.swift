//
//  LoginPageProtocol.swift
//  PlateiOS
//
//  Created by Renner Leite Lucena on 11/28/17.
//  Copyright © 2017 Renner Leite Lucena. All rights reserved.
//

import UIKit

protocol LoginPageProtocol : class {
    
    func showErrorMessage(title: String, message: String)
    func openViewController(controller: UIViewController)
    func presentViewController(controller: UIViewController)
}
