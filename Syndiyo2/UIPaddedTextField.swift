//
//  UIRoundTextField.swift
//  Syndiyo2
//
//  Created by Ilham Nurjadin on 7/20/16.
//  Copyright © 2016 Alan-Yu. All rights reserved.
//

import UIKit

class UIPaddedTextField: UITextField {
    
    var padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5)
    var padded: Bool = true {
        didSet {
            if padded == false { padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) }
            if padded == true { padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15) }
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
