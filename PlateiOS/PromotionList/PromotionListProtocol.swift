//
//  PromotionListProtocol.swift
//  PlateiOS
//
//  Created by Renner Leite Lucena on 10/20/17.
//  Copyright © 2017 Renner Leite Lucena. All rights reserved.
//

import UIKit

protocol PromotionListProtocol : class {
    
    func showErrorMessage(title : String, message: String)
    func reloadTable()
    func showLoading()
    func hideLoading()
    func showAlert(title: String, message: String, arrayOfActions: [UIAlertAction])
    func loadTable()
    func openViewController(controller: UIViewController)
    func presentViewController(controller: UIViewController)
}
