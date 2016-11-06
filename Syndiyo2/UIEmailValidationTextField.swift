//
//  UIEmailValidationTextField.swift
//  Syndiyo2
//
//  Created by Ilham Nurjadin on 7/20/16.
//  Copyright © 2016 Alan-Yu. All rights reserved.
//

import UIKit

class UIEmailValidationTextField: UIValidationTextField {

    override var isValid: Bool {
        if text == nil { return false }
        if text == "" { return false }

        do{
        let regex = try NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
            
//            let index = text!.rangeOfString("@")?.startIndex
//            
//            
//            
//            
//            print(index!)
//            

        
        return regex.firstMatch( in: text! , options: [], range: NSMakeRange(0, text!.characters.count)) != nil
        }catch {
          return  false
        }
    }

}
