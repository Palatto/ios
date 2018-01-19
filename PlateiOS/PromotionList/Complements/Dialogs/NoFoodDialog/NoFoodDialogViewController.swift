//
//  NoFoodDialogViewController.swift
//  PlateiOS
//
//  Created by Nick Machado on 12/25/17.
//  Copyright © 2017 Renner Leite Lucena. All rights reserved.
//

import UIKit
import Foundation

class NoFoodDialogViewController: UIViewController {
    
    var promotionModel: PromotionModel?
    var positiveFunction: (() -> Void)?
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var noFoodDialog: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTapCloseAction()
        setupUI()
    }
}

extension NoFoodDialogViewController {
    
    fileprivate func setupUI() {
        let confirmationPopUpView = ConfirmationPopUp.makeXib()
        showConfirmationPopUp(confirmationPopUpView: confirmationPopUpView)
    }
    
    fileprivate func setupTapCloseAction() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        backgroundView.addGestureRecognizer(tap)
    }
    
    @objc func handleTap() {
        self.dismissAnimated()
    }
    
    public func closePopup() {
        self.dismissAnimated()
    }
}

extension NoFoodDialogViewController {
    
    fileprivate func dismissAnimated() {
        self.view.subviews.forEach { $0.removeFromSuperview() }
        
        DispatchQueue.main.async {
            self.dismiss(animated: true)
        }
    }
    
    fileprivate func showConfirmationPopUp(confirmationPopUpView: ConfirmationPopUp) {
        confirmationPopUpView.negativeFunction = { [weak self] in
            self?.closePopup()
        }
        
        confirmationPopUpView.positiveFunction = { [weak self] in
            self?.positiveFunction?()
            self?.closePopup()
        }
        
        guard let title = self.promotionModel?.title, let location = self.promotionModel?.location else { return }
        confirmationPopUpView.title = title
        confirmationPopUpView.location = location
        
        noFoodDialog.addSubview(confirmationPopUpView)
        
        DispatchQueue.main.async {
            self.addConstraintsModelContainer(with: confirmationPopUpView)
            UIView.animate(withDuration: 0.5) { [weak self] in self?.noFoodDialog.alpha = 1 }
        }
    }
    
    fileprivate func addConstraintsModelContainer(with subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.topAnchor.constraint(equalTo: noFoodDialog.topAnchor).isActive = true
        subview.bottomAnchor.constraint(equalTo: noFoodDialog.bottomAnchor).isActive = true
        subview.trailingAnchor.constraint(equalTo: noFoodDialog.trailingAnchor).isActive = true
        subview.leadingAnchor.constraint(equalTo: noFoodDialog.leadingAnchor).isActive = true
    }
}
