//
//  UIEmailValidationTextField.swift
//  Syndiyo2
//
//  Created by Ilham Nurjadin on 7/20/16.
//  Copyright © 2016 Alan-Yu. All rights reserved.
//

import UIKit

class UIEmailValidationTextField: UIAutoValidateTextField {

    override var isValid: Bool {
        if text == nil { return false }
        return UserController.sharedInstance.checkUsernameAvailability(text!)
    }

}
