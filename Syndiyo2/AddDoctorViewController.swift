//
//  AddDoctorViewController.swift
//  Syndiyo2
//
//  Created by Ilham Nurjadin on 7/20/16.
//  Copyright © 2016 Alan-Yu. All rights reserved.
//

import UIKit

class AddDoctorViewController: UIViewController {
    
    
    

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var doctorNameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var emailTextField: UIEmailValidationTextField!
    @IBOutlet weak var faxTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var topLabel: UILabel!
    
    var delegate:AddDoctorDelegate?
    
    
    var addingDoctor:Bool = true
    var editingDoctor:Bool = true
    var currentDoctor:Doctor?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.clear
        view.isOpaque = false
        
        
        addButton.layer.cornerRadius = 15
        
//        cardView.layer.shadowColor = UIColor.blueColor().CGColor
//        cardView.layer.shadowOpacity = 1
//        cardView.layer.shadowOffset = CGSizeZero
//        cardView.layer.shadowRadius = 10
//        cardView.layer.shadowPath = UIBezierPath(rect: self.bounds).CGPath
        
        
        if editingDoctor {
            doctorNameTextField.text = currentDoctor?.name
            locationTextField.text = currentDoctor?.address
            emailTextField.text = currentDoctor?.email
            faxTextField.text = currentDoctor?.fax
            phoneTextField.text = currentDoctor?.phone
            
            addButton.setTitle("Done", for: UIControlState())
            topLabel.text = "Edit Doctor"
        }
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonClicked))
        
        self.navigationItem.title = "Add Doctor"
        self.navigationItem.leftBarButtonItem = cancelButton
        
        emailTextField.padded = false

        
    }
    
    
    
    
    @IBAction func dismissKeyboard(_ sender: AnyObject) {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    func cancelButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addButtonClicked(_ sender: AnyObject) {
        print(addingDoctor)
        print(editingDoctor)
        if addingDoctor {
            print("I'm here 1")
            let newDoctor = Doctor(name: doctorNameTextField.text!, speciality: nil, address: locationTextField.text!, email: emailTextField.text!, fax: faxTextField.text!, phone: phoneTextField.text!, profilePic: nil)
            UserController.sharedInstance.addDoctors([newDoctor])
            self.dismiss(animated: true, completion: nil)
        } else if editingDoctor {
            print("i'm here 2")
            currentDoctor?.name = doctorNameTextField.text!
            currentDoctor?.address = locationTextField.text!
            currentDoctor?.email = emailTextField.text!
            currentDoctor?.fax = faxTextField.text!
            currentDoctor?.phone = phoneTextField.text!
            
            UserController.sharedInstance.updateDoctorsArray()
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    
    @IBAction func donePresed(_ sender: AnyObject) {
        
        sender.resignFirstResponder()
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.didDisappear()
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
