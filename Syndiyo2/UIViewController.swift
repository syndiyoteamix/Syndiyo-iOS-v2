//
//  UIViewController.swift
//  Syndiyo2
//
//  Created by Ilham Nurjadin on 7/19/16.
//  Copyright © 2016 Alan-Yu. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func createAlert(titleMessage: String, submessage: String, onDismiss: (UIAlertAction) -> Void) {
        
        // creates an alert (programatically as opposed to using storyboard)
        let alert = UIAlertController(title: titleMessage, message:  submessage, preferredStyle: UIAlertControllerStyle.Alert)
        
        // creating alert actions (buttons)
        let alertActionDismiss = UIAlertAction(title: "Dismiss", style: .Cancel, handler: onDismiss)
        
        // add actions/buttons
        alert.addAction(alertActionDismiss)
        
        // present the alert in the view
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func makeViewDropKeyboard()   {
        print("makeViewDropTapped")
        self.view.endEditing(true);
        self.resignFirstResponder()
    }
    
    func setupKeyboardNotifications(addDropKeyboardRecogniser:Bool = true)   {
        
        //add this view as an observer to keyboard notifications
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
        
        if (addDropKeyboardRecogniser)   {
            
            //and add a gesture recogniser to drop keyboard when the view background is tapped
            let tapGestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(UIViewController.makeViewDropKeyboard))
            self.view.addGestureRecognizer(tapGestureRecogniser)
            
        }
        
    }
    
    
}