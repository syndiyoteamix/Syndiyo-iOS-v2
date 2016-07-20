//
//  UISSNTextField.swift
//  Syndiyo2
//
//  Created by Ilham Nurjadin on 7/20/16.
//  Copyright © 2016 Alan-Yu. All rights reserved.
//

import UIKit

class UISSNTextField: UIValidationTextField {

    override var isValid: Bool {
        if text == nil { return false }
        if text == "" { return false }
        if text!.characters.count != 12 { return false }
        return true
    }

}
