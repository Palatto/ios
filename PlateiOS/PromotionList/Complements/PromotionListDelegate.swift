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

// See that this extension basically implements a protocol, ones that is standard for
// tableViews, necessary to make it work.
extension PromotionListDelegate : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
