//
//  LandingViewController.swift
//  Syndiyo
//
//  Created by Ilham Nurjadin on 7/18/16.
//  Copyright © 2016 Alan-Yu. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UIPaddedTextField!
    @IBOutlet weak var passwordTextField: UIPaddedTextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    
    @IBOutlet weak var yOriginOfInputContainer: NSLayoutConstraint!
    @IBOutlet weak var logoToTopConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signInButton.alpha = 0.5
        signInButton.layer.cornerRadius = 20
        emailTextField.layer.cornerRadius = 20
        passwordTextField.layer.cornerRadius = 20
        
        emailTextField.padded = true
        passwordTextField.padded = true
        
        emailTextField.isEnabled = true
        
        // so we can react to keyboard
        setupKeyboardNotifications()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.navigationController?.navigationBarHidden = true
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //self.navigationController?.navigationBarHidden = false
        navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
    @IBAction func textFieldChanged(_ sender: AnyObject) {
        if verified() {
            signInButton.isEnabled = true
            signInButton.alpha = 1
        }
        else {
            signInButton.isEnabled = false
            signInButton.alpha = 0.5
        }
    }
    
    
    func verified() -> Bool {
        
        for subview in containerView.subviews {
            if let textField = subview as? UITextField {
                if textField.text == nil { return false }
                if textField.text == "" { return false }
            }
        }
        
        return true
    }
    
    @IBAction func signInButtonPressed(_ sender: AnyObject) {
        
        UserController.sharedInstance.loginUser(emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            
            
            if user != nil {
                print("hello")
                UserController.sharedInstance.currentUser = user
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateInitialViewController()
                let application = UIApplication.shared
                let window = application.keyWindow
                window?.rootViewController = viewController
               
            } else {
                
                
                
          
                self.createAlert(error!, submessage: "Please try again") { action in }
                self.emailTextField.text = ""
                self.passwordTextField.text = ""
              
            }
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: AnyObject) {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    
    ///////
    
    
    
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
                yOriginOfInputContainer.constant = 60
                logoToTopConstraint.constant = 60
            }
            else {
                yOriginOfInputContainer.constant = 100
                logoToTopConstraint.constant = 120
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
