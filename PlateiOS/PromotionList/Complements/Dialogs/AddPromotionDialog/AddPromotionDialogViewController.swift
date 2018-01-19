//
//  AddPromotionDialogViewController.swift
//  PlateiOS
//
//  Created by Renner Leite Lucena on 1/8/18.
//  Copyright © 2018 Renner Leite Lucena. All rights reserved.
//

import UIKit
import Foundation

class AddPromotionDialogViewController: UIViewController {
    
    var positiveFunction: ((PromotionModel) -> Void)?
    var errorFunction: (() -> Void)?
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var addPromotionDialog: UIView!
    @IBOutlet weak var constraintOffset: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTapCloseAction()
        setupUI()
    }
}

extension AddPromotionDialogViewController {
    
    fileprivate func setupTapCloseAction() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        backgroundView.addGestureRecognizer(tap)
    }
    
    @objc func handleTap() {
        if(constraintOffset.constant == 0) {
            self.dismissAnimated()
        }
    }
    
    fileprivate func setupUI() {
        let inputPopUpView = InputPopUp.makeXib()
        prepareAndShowInputPopUp(inputPopUpView: inputPopUpView)
    }
    
    func closePopup() {
        self.dismissAnimated()
    }
}

extension AddPromotionDialogViewController {
    
    fileprivate func dismissAnimated() {
        self.view.subviews.forEach { $0.removeFromSuperview() }
        
        DispatchQueue.main.async {
            self.dismiss(animated: true)
        }
    }
    
    fileprivate func prepareAndShowInputPopUp(inputPopUpView: InputPopUp) {
        inputPopUpView.negativeFunction = { [weak self] in
            self?.closePopup()
        }
        
        inputPopUpView.positiveFunction = { [weak self] promotionModel in
            self?.positiveFunction?(promotionModel)
            self?.closePopup()
        }
        
        inputPopUpView.errorFunction = { [weak self] in
            self?.errorFunction?()
            self?.closePopup()
        }
        
        inputPopUpView.textFieldDidBeginEditingFunction = { [weak self] in
            self?.constraintOffset.constant = -100
            self?.view.layoutIfNeeded()
        }
        
        inputPopUpView.textFieldDidEndEditingFunction = { [weak self] in
            self?.view.endEditing(true)
            self?.constraintOffset.constant = 0
            self?.view.layoutIfNeeded()
        }
        
        addPromotionDialog.addSubview(inputPopUpView)
        
        DispatchQueue.main.async {
            self.addConstraintsModelContainer(with: inputPopUpView)
            UIView.animate(withDuration: 0.5) { [weak self] in self?.addPromotionDialog.alpha = 1 }
        }
    }
    
    fileprivate func addConstraintsModelContainer(with subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.topAnchor.constraint(equalTo: addPromotionDialog.topAnchor).isActive = true
        subview.bottomAnchor.constraint(equalTo: addPromotionDialog.bottomAnchor).isActive = true
        subview.trailingAnchor.constraint(equalTo: addPromotionDialog.trailingAnchor).isActive = true
        subview.leadingAnchor.constraint(equalTo: addPromotionDialog.leadingAnchor).isActive = true
    }
}
