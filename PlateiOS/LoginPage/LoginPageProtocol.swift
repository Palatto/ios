//
//  LoginPageProtocol.swift
//  PlateiOS
//
//  Created by Renner Leite Lucena on 11/28/17.
//  Copyright © 2017 Renner Leite Lucena. All rights reserved.
//

import UIKit

protocol LoginPageProtocol : class {
    
    func showErrorMessage(message: String)
    func showAlert()
    func setItemsList(promotions: [PromotionModel])
}
