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
        
        nextButton.layer.cornerRadius = 20
        nextButton.alpha = 0.5
        
        passwordTextField.padded = false
        verifyPasswordTextField.padded = false
        
        setupKeyboardNotifications()
        
    }
    
    @IBAction func textFieldChanged(_ sender: AnyObject) {
        if verified() {
            nextButton.isEnabled = true
            nextButton.alpha = 1
        }
        else {
            nextButton.isEnabled = false
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

    @IBAction func nextButtonPressed(_ sender: AnyObject) {
        UserController.sharedInstance.currentUser?.password = passwordTextField.text!
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    ///////////////
    
    @IBOutlet weak var topImageConstraintToTop: NSLayoutConstraint!
    @IBOutlet weak var promptToTopImageConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerToPromptConstraint: NSLayoutConstraint!
    @IBOutlet weak var nextButtonToTextConstraint: NSLayoutConstraint!
    
    func keyboardWillShow(_ notification: Notification) {
        
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let duration:TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions().rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            
            //if the phone is < 5, then the keyboard will overlay the textfields when it comes up. accomodate for
            self.updateUIForKeyboard(endFrame,keyboardDirectionUp:true)
            
            UIView.animate(withDuration: duration,
                                       delay: TimeInterval(0),
                                       options: animationCurve,
                                       animations: {
                                        self.view.layoutIfNeeded()
                },
                                       completion: nil)
        }
    }
    
    
    func updateUIForKeyboard(_ endFrame:CGRect!, keyboardDirectionUp:Bool)  {
        if (keyboardDirectionUp) {
            topImageConstraintToTop.constant = 20
            promptToTopImageConstraint.constant = 5
            containerToPromptConstraint.constant = 10
            nextButtonToTextConstraint.constant = 20
        }
        else {
            topImageConstraintToTop.constant = 80
            promptToTopImageConstraint.constant = 20
            containerToPromptConstraint.constant = 30
            nextButtonToTextConstraint.constant = 30
        } //the original value from the nib
    }
    
    func keyboardWillHide(_ notification: Notification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let duration:TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions().rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            
            self.view.endEditing(true);
            self.resignFirstResponder()
            //reset the frame to 0;0
            var newFrame = self.view.frame
            newFrame.origin.y = 0
            newFrame.size.height = UIScreen.main.bounds.height
            self.view.frame = newFrame
            
            self.updateUIForKeyboard(endFrame, keyboardDirectionUp:false)
            
            //do the animation
            UIView.animate(withDuration: duration,
                                       
                                       delay: TimeInterval(0),
                                       options: animationCurve,
                                       animations: {
                                        self.view.layoutIfNeeded()
                },
                                       completion: nil)
        }
        
    }
    
    
}
