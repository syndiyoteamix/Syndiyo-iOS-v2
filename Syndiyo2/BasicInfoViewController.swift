//
//  SignUpViewController.swift
//  Syndiyo
//
//  Created by Ilham Nurjadin on 7/18/16.
//  Copyright © 2016 Alan-Yu. All rights reserved.
//

import UIKit

class BasicInformationViewController: UIViewController {

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        // Tap to dismiss keyboard
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
//        view.addGestureRecognizer(tap)
        
        // Configuration of nextButton
        nextButton.layer.cornerRadius = 15
        nextButton.alpha = 0.5
        nextButton.enabled = false
        
        // Set firstNameTextField to first responder
        
    }
    
    @IBAction func nextButtonPressed(sender: AnyObject) {
        UserController.sharedInstance.currentUser = User(firstName: firstNameTextField.text, lastName: lastNameTextField.text, email: emailTextField.text, password: "", ssn: 0, doctorsArray: nil, medicalInfo: nil)
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
    
    @IBAction func textFieldChanged(sender: UITextField) {
        if verified() {
            nextButton.enabled = true
            nextButton.alpha = 1
        }
        else {
            nextButton.enabled = false
            nextButton.alpha = 0.5
        }
    }
    
    //Calls this function when the tap is recognized.
    @IBAction func dismissKeyboard(sender: AnyObject) {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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
