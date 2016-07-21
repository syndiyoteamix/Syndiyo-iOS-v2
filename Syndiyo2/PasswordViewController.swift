//
//  PasswordViewController.swift
//  Syndiyo2
//
//  Created by Ilham Nurjadin on 7/20/16.
//  Copyright © 2016 Alan-Yu. All rights reserved.
//

import UIKit

class PasswordViewController: UIViewController {
    
    @IBOutlet weak var passwordTextField: UIPasswordValidatingTextField!
    @IBOutlet weak var verifyPasswordTextField: UIVerifyPasswordTextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var topContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Tap to dismiss keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        containerView.addGestureRecognizer(tap)
        topContainerView.addGestureRecognizer(tap)
        
        nextButton.layer.cornerRadius = 15
        nextButton.alpha = 0.5
        
    }
    
    @IBAction func textFieldChanged(sender: AnyObject) {
        if verified() {
            nextButton.enabled = true
            nextButton.alpha = 1
        }
        else {
            nextButton.enabled = false
            nextButton.alpha = 0.5
        }
    }
    
    func verified() -> Bool {
        
        for subview in containerView.subviews {
            if let textField = subview as? UITextField {
                if textField.text == nil { return false }
                if textField.text == "" { return false }
            }
        }
        
        verifyPasswordTextField.validateText = passwordTextField.text!
        if !verifyPasswordTextField.isValid { return false }
        
        return true
    }

    @IBAction func nextButtonPressed(sender: AnyObject) {
        UserController.sharedInstance.currentUser?.password = passwordTextField.text!
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
