//
//  ConfirmationPopUp.swift
//  PlateiOS
//
//  Created by Nick Machado on 12/25/17.
//  Copyright © 2017 Renner Leite Lucena. All rights reserved.
//

import UIKit

class ConfirmationPopUp: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBAction func negativeClicked(_ sender: Any) {
        negativeFunction?()
    }
    
    @IBAction func positiveClicked(_ sender: Any) {
        positiveFunction?()
    }
    
    @IBOutlet weak var negativeButton: UIButton! {
        didSet {
            negativeButton.setTitleColor(PlateColors.darkerGray, for: .normal)
        }
    }
    
    @IBOutlet weak var positiveButton: UIButton! {
        didSet {
            positiveButton.setTitleColor(PlateColors.mainBlue, for: .normal)
        }
    }
    
    var negativeFunction: (() -> Void)?
    var positiveFunction: (() -> Void)?
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    var location: String? {
        didSet {
            locationLabel.text = location
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 4
        clipsToBounds = true
    }
}
