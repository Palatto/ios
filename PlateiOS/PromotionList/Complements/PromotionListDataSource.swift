//
//  PromotionListDataSource.swift
//  PlateiOS
//
//  Created by Renner Leite Lucena on 11/20/17.
//  Copyright © 2017 Renner Leite Lucena. All rights reserved.
//

import Foundation
import UIKit

final class PromotionListDataSource : NSObject {
    public var promotionListController: PromotionListController?
}

extension PromotionListDataSource : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let quantityOfItems = promotionListController?.promotionList.quantityOfItems() else {
            return 0
        }
        return quantityOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let promotionModel = promotionListController?.promotionList.promotions[indexPath.row] else { return UITableViewCell() }
        guard let firstClick = promotionListController?.promotionList.promotionsStatus[promotionModel] else { return UITableViewCell() }
        guard let tableCell = tableView.dequeueReusableCell(withIdentifier: "PromotionCell", for: indexPath) as? PromotionCell else { return UITableViewCell() }
        
        tableCell.initCell(promotionModel: promotionModel, firstClick: firstClick, respondToCellButtonClick: { [weak self] promotionModel, firstClick in
            self?.promotionListController?.respondToCellButtonClickOnController(promotionModel: promotionModel, firstClick: firstClick)
        })
        
        return tableCell
    }
}
