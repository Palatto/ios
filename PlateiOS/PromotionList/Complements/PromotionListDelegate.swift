//
//  PromotionsListDelegate.swift
//  PlateiOS
//
//  Created by Renner Leite Lucena on 11/20/17.
//  Copyright © 2017 Renner Leite Lucena. All rights reserved.
//

import Foundation
import UIKit

final class PromotionListDelegate : NSObject {}

extension PromotionListDelegate : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
