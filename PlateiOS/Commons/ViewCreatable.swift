//
//  ViewCreatable.swift
//  PlateiOS
//
//  Created by Nick Machado on 12/25/17.
//  Copyright © 2017 Renner Leite Lucena. All rights reserved.
//

import UIKit

protocol ViewCreatable { }

extension ViewCreatable where Self : UIView {
    
    static func makeXib() -> Self {
        
        let identifier = String(describing: Self.self)
        guard let view = Bundle.main.loadNibNamed(identifier, owner: self, options: nil)?.first as? Self else {
            
            fatalError("It was not possible create Xib with identifier: \(identifier). The '.xib' and '.swift' files must have the same name.")
        }
        
        return view
    }
}

extension UIView : ViewCreatable { }
