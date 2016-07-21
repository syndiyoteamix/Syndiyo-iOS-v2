//
//  UIRoundTextField.swift
//  Syndiyo2
//
//  Created by Ilham Nurjadin on 7/20/16.
//  Copyright © 2016 Alan-Yu. All rights reserved.
//

import UIKit

class UIRoundTextField: UITextField {
    
    var padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5)
    var padded: Bool = true {
        didSet {
            if padded == false { padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5) }
            if padded == true { padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5) }
        }
    }
    
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func placeholderRectForBounds(bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }

}
