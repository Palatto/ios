//
//  PromotionCell.swift
//  PlateiOS
//
//  Created by Renner Leite Lucena on 11/17/17.
//  Copyright © 2017 Renner Leite Lucena. All rights reserved.
//

import UIKit

class PromotionCell: UITableViewCell {
    
    var promotionModel: PromotionModel? = nil
    var firstClick: Bool? = nil
    var respondToCellButtonClick: ((PromotionModel, Bool) -> Void)?
    
    @IBOutlet weak var title: UILabel! {
        didSet {
            title.textColor = UIColor.black
        }
    }
    
    @IBOutlet weak var location: UILabel! {
        didSet {
            location.textColor = PlateColors.mainGray
        }
    }
    
    @IBOutlet weak var time: UILabel! {
        didSet {
            time.textColor = PlateColors.mainGray
        }
    }
    
    @IBOutlet weak var buttonOutlet: UIButton! {
        didSet {
            buttonOutlet.titleLabel?.textAlignment = NSTextAlignment.center
        }
    }
    
    @IBOutlet weak var verticalLine: UIView! {
        didSet {
            verticalLine.backgroundColor = PlateColors.darkerGray
        }
    }
    
    @IBAction func buttonAction(_ sender: Any) {
        guard let promotionModel = self.promotionModel, let firstClick = self.firstClick else { return }
        self.respondToCellButtonClick?(promotionModel, firstClick)
    }
}

extension PromotionCell {
    
    public func initCell(promotionModel: PromotionModel, firstClick: Bool, respondToCellButtonClick: @escaping (_ promotionModel: PromotionModel, _ firstClick: Bool) -> Void) {
        self.firstClick = firstClick
        self.promotionModel = promotionModel
        self.respondToCellButtonClick = respondToCellButtonClick
        
        title.text = promotionModel.title
        location.text = promotionModel.location
       // time.text = promotionModel.getParsedDateTime()
        
        if(firstClick) {
            buttonOutlet.setTitle("GO", for: .normal)
            buttonOutlet.setTitleColor(PlateColors.mainBlue, for: .normal)
        }else {
            buttonOutlet.setTitle("CLICK IF NO FOOD IS LEFT", for: .normal)
            buttonOutlet.setTitleColor(PlateColors.mainLightBlue, for: .normal)
        }
    }
}
