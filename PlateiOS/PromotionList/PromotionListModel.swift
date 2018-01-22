//
//  PromotionListModel.swift
//  PlateiOS
//
//  Created by Renner Leite Lucena on 11/17/17.
//  Copyright © 2017 Renner Leite Lucena. All rights reserved.
//

import Foundation

class PromotionListModel {
    
    var promotions: [PromotionModel]
    var promotionsStatus: [PromotionModel : Bool]
    
    init() {
        promotions = []
        promotionsStatus = [:]
    }
}

extension PromotionListModel {
    
    public func clearPromotions() {
        promotions.removeAll()
        promotionsStatus.removeAll()
    }
    
    public func quantityOfItems() -> Int {
        return promotions.count
    }
    
    public func addPromotion(promotionModel : PromotionModel) {
        promotions.append(promotionModel)
        promotionsStatus[promotionModel] = true
    }
    
    public func removePromotion(promotionModel : PromotionModel){
        let index = promotions.index(of: promotionModel)
        promotions.remove(at: index!)
        promotionsStatus.removeValue(forKey: promotionModel)
    }
}
