//
//  LandingViewController.swift
//  Syndiyo
//
//  Created by Ilham Nurjadin on 7/18/16.
//  Copyright © 2016 Alan-Yu. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.alpha = 0.5
        loginButton.layer.cornerRadius = 15
        usernameTextField.layer.cornerRadius = 10
        passwordTextField.layer.cornerRadius = 10
        
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
    
    @IBAction func textFieldChanged(sender: UITextField) {
        if verified() {
            loginButton.enabled = true
            loginButton.alpha = 1
        }
        else {
            loginButton.enabled = false
            loginButton.alpha = 0.5
        }
    }
    
    func verified() -> Bool {
        
        for subview in containerView.subviews as [UIView] {
            if let textField = subview as? UITextField {
                if textField.text == nil { return false }
                if textField.text == "" { return false }
            }
        }
        
        return true
    }
    
    @IBAction func loginButtonPressed(sender: AnyObject) {
        UserController.sharedInstance.loginUser(usernameTextField.text!, password: passwordTextField.text!) { user, error in
            if user != nil {
                UserController.sharedInstance.currentUser = user
            }
            self.createAlert(error!, submessage: "Please try again") { action in }
            self.usernameTextField.text = ""
            self.passwordTextField.text = ""
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
