//
//  LandingViewController.swift
//  Syndiyo
//
//  Created by Ilham Nurjadin on 7/18/16.
//  Copyright © 2016 Alan-Yu. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UIRoundTextField!
    @IBOutlet weak var passwordTextField: UIRoundTextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signInButton.alpha = 0.5
        signInButton.layer.cornerRadius = 15
        emailTextField.layer.cornerRadius = 15
        passwordTextField.layer.cornerRadius = 15
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //self.navigationController?.navigationBarHidden = true
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        //self.navigationController?.navigationBarHidden = false
        navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
    @IBAction func ButtonPressed(sender: AnyObject) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController()
        let application = UIApplication.sharedApplication()
        let window = application.keyWindow
        window?.rootViewController = viewController
        
    }
    
    @IBAction func textFieldChanged(sender: AnyObject) {
        if verified() {
            signInButton.enabled = true
            signInButton.alpha = 1
        }
        else {
            signInButton.enabled = false
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
    
    @IBAction func signInButtonPressed(sender: AnyObject) {
        
        UserController.sharedInstance.loginUser(emailTextField.text!, password: passwordTextField.text!) { user, error in
            if user != nil {
                UserController.sharedInstance.currentUser = user
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateInitialViewController()
                let application = UIApplication.sharedApplication()
                let window = application.keyWindow
                window?.rootViewController = viewController
            } else {
                self.createAlert(error!, submessage: "Please try again") { action in }
                self.emailTextField.text = ""
                self.passwordTextField.text = ""
            }
        }
    }
    
//    @IBAction func signInButtonPressed(sender: AnyObject) {
//        
//        UserController.sharedInstance.loginUser(<#T##email: String##String#>, password: <#T##String#>, onCompletion: <#T##(User?, String?) -> Void#>)
//        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let viewController = storyboard.instantiateInitialViewController()
//        let application = UIApplication.sharedApplication()
//        let window = application.keyWindow
//        window?.rootViewController = viewController
//        
//    }
    

}
