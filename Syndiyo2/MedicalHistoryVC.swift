//
//  MedicalHistoryVC.swift
//  Syndiyo2
//
//  Created by Alan Yu on 7/22/16.
//  Copyright © 2016 Alan-Yu. All rights reserved.
//

import UIKit

class MedicalHistoryVC: UIViewController {
    
    
    @IBOutlet weak var DOB: UIDateField!
    
    @IBOutlet weak var height: UITextField!
    
    @IBOutlet weak var weight: UITextField!
    
    @IBOutlet weak var allergies: UITextField!
    
    @IBOutlet weak var previousMedicalConditions: UITextField!

    @IBOutlet weak var medications: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let myself = UserController.sharedInstance.currentUser!.medicalInfo
        
        print(UserController.sharedInstance.currentUser)
        
        
        if let dob = myself!.dob {
            DOB.date = dob
        }else {
            DOB.text = ""
        }
        
        height.text = myself?.height
        weight.text = myself?.weight
        allergies.text = myself?.allergies
        previousMedicalConditions.text = myself?.previousMedicalConditions
        medications.text = myself?.medications
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
          UserController.sharedInstance.currentUser?.medicalInfo = MedicalInformation(dob: DOB.date, height: String(height.text!) ?? "", weight: String(weight.text!) ?? "", allergies: allergies.text!, previousMedicalConditions: previousMedicalConditions.text!, medications: medications.text!)
    }
    
    @IBAction func dismissKeyboard(_ sender: AnyObject) {
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
