//
//  PromotionCell.swift
//  PlateiOS
//
//  Created by Renner Leite Lucena on 11/17/17.
//  Copyright © 2017 Renner Leite Lucena. All rights reserved.
//

import UIKit

class PromotionCell: UITableViewCell {
    //Outlets for cell elements
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var buttonObj: UIButton!
    
    @IBAction func goButton(_ sender: Any) {
        
        // Allows user to confirm they are going and creates a distinction between confirmed xibs.
        if(buttonObj.currentTitle == "GO" ) {
            buttonObj.setTitle("CONFIRMED", for: .normal)
            buttonObj.backgroundColor = UIColor.blue
        }
        else{
            //Update calls once the database says there is no food left. No database information for this yet to retrieve, so I just have it set as the second click.
            buttonObj.setTitle("No Food Left", for: .normal)
            buttonObj.backgroundColor = UIColor.red
        }
    }
}

//Extension (for organization) that contains one single function
extension PromotionCell {
    
    // Function that updates the outlet labels
    public func updateLabels(promotionModel: PromotionModel) {
        title.text = promotionModel.title
        location.text = promotionModel.location
        time.text = promotionModel.getTime()
    }
}
