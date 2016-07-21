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
        nextButton.layer.cornerRadius = 15
        nextButton.alpha = 0.5
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
    
    
    func verified() -> Bool {
        
        if ssnTextField.text == nil { return false }
        if !ssnTextField.isValid { return false }
        
        return true
    }
    
    @IBAction func nextButtonPressed(sender: AnyObject) {
        
        UserController.sharedInstance.registerUser { error in
            if error != nil {
                self.createAlert(error!, submessage: "Please try again") { action in }
            }
            else {
                let viewController = GetStartedViewController(nibName: "GetStartedViewController", bundle: nil)
                self.navigationController?.pushViewController(viewController, animated: true)
                
            }
            
        }
        
    }

}
