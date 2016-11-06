//
//  UIViewController.swift
//  Syndiyo2
//
//  Created by Ilham Nurjadin on 7/19/16.
//  Copyright © 2016 Alan-Yu. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func createAlert(_ titleMessage: String, submessage: String, onDismiss: @escaping (UIAlertAction) -> Void) {
        
        // creates an alert (programatically as opposed to using storyboard)
        let alert = UIAlertController(title: titleMessage, message:  submessage, preferredStyle: UIAlertControllerStyle.alert)
        
        // creating alert actions (buttons)
        let alertActionDismiss = UIAlertAction(title: "Dismiss", style: .cancel, handler: onDismiss)
        
        // add actions/buttons
        alert.addAction(alertActionDismiss)
        
        // present the alert in the view
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func makeViewDropKeyboard()   {
        print("makeViewDropTapped")
        self.view.endEditing(true);
        self.resignFirstResponder()
    }
    
    func setupKeyboardNotifications(_ addDropKeyboardRecogniser:Bool = true)   {
        
        //add this view as an observer to keyboard notifications
        NotificationCenter.default.addObserver(self, selector: Selector("keyboardWillShow:"), name:NSNotification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: Selector("keyboardWillHide:"), name:NSNotification.Name.UIKeyboardWillHide, object: nil);
        
        if (addDropKeyboardRecogniser)   {
            
            //and add a gesture recogniser to drop keyboard when the view background is tapped
            let tapGestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(UIViewController.makeViewDropKeyboard))
            self.view.addGestureRecognizer(tapGestureRecogniser)
            
        }
        
    }
    
    
}
