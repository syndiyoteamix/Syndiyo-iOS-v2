//
//  SSNViewController.swift
//  Syndiyo2
//
//  Created by Ilham Nurjadin on 7/20/16.
//  Copyright © 2016 Alan-Yu. All rights reserved.
//

import UIKit

class SSNViewController: UIViewController {

    @IBOutlet weak var ssnTextField: UISSNTextField!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.layer.cornerRadius = 20
        nextButton.alpha = 0.5
        
        ssnTextField.padded = false
        
        setupKeyboardNotifications()
    }
    
    @IBAction func textFieldChanged(_ sender: UITextField) {
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
        
        if ssnTextField.text == nil { return false }
        if !ssnTextField.isValid { return false }
        
        return true
    }
    
    @IBAction func nextButtonPressed(_ sender: AnyObject) {
        
        UserController.sharedInstance.registerUser { error in
            if error != nil {
                
                print("shit")
                self.createAlert(error!, submessage: "Please try again") { action in }
            }
            else {
                let viewController = GetStartedViewController(nibName: "GetStartedViewController", bundle: nil)
                self.navigationController?.pushViewController(viewController, animated: true)
                
            }
            
        }
        
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
            topImageConstraintToTop.constant = 40
            promptToTopImageConstraint.constant = 5
            containerToPromptConstraint.constant = 20
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
