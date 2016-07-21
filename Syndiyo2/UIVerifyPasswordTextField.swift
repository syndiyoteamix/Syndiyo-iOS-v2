//
//  UIVerifyPasswordTextField.swift
//  Syndiyo2
//
//  Created by Ilham Nurjadin on 7/20/16.
//  Copyright © 2016 Alan-Yu. All rights reserved.
//

import UIKit

class UIVerifyPasswordTextField: UIValidationTextField {

    var validateText: String = ""
    
    override var isValid: Bool {
        if text == nil { return false }
        if text != validateText { return false }
        return true
    }
    
}
