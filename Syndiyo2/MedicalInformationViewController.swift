//
//  MedicalInformationViewController.swift
//  Syndiyo2
//
//  Created by Ilham Nurjadin on 7/20/16.
//  Copyright © 2016 Alan-Yu. All rights reserved.
//

import UIKit

class MedicalInformationViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var dateOfBirthTextField: UIDateField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var allergiesTextField: UITextField!
    @IBOutlet weak var previousMedicalConditionsTextfield: UITextField!
    @IBOutlet weak var medicationsTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configuration of SkipButton
        skipButton.layer.cornerRadius = 5
        
        // Configuration of nextButton
        nextButton.layer.cornerRadius = 5
        
        // Tap to dismiss keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        containerView.addGestureRecognizer(tap)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextButtonPressed(sender: AnyObject) {
        UserController.sharedInstance.currentUser?.medicalInfo = MedicalInformation(dob: dateOfBirthTextField.date, height: Int(heightTextField.text!) ?? 0, weight: Int(weightTextField.text!) ?? 0, allergies: [allergiesTextField.text!], previousMedicalConditions: [previousMedicalConditionsTextfield.text!], medications: [medicationsTextField.text!])
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

}
