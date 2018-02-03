//
//  SplashScreenViewController.swift
//  PlateiOS
//
//  Created by Renner Leite Lucena on 1/13/18.
//  Copyright © 2018 Renner Leite Lucena. All rights reserved.
//

import Foundation

import UIKit

class SplashScreenViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delayWithSeconds(1) {
            let defaults = UserDefaults.standard
            if (defaults.bool(forKey: "isLoggedIn") == true) {
                let username = defaults.string(forKey: "username")!
                let promotionListViewController = UIStoryboard.init(name: "PromotionList", bundle: nil).instantiateViewController(withIdentifier: "PromotionList")
                    as! PromotionListViewController
                promotionListViewController.username = username
                self.openViewController(controller: promotionListViewController)
            } else {
                let loginPageViewController = UIStoryboard.init(name: "LoginPage", bundle: nil).instantiateViewController(withIdentifier: "LoginPage")
                    as! LoginPageViewController
                self.openViewController(controller: loginPageViewController)
            }
        }
    }
    
    fileprivate func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }
    
    fileprivate func openViewController(controller: UIViewController) {
        DispatchQueue.main.async {
            self.show(controller, sender: nil)
        }
    }
}
