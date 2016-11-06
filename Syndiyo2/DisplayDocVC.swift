//
//  DisplayDocVC.swift
//  Syndiyo2
//
//  Created by Alan Yu on 7/20/16.
//  Copyright © 2016 Alan-Yu. All rights reserved.
//

import UIKit

class DisplayDocVC: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate  {
    
    @IBOutlet weak var documentImage: UIImageView!
    
    @IBOutlet weak var titleTF: UITextField!
    
    @IBOutlet weak var dateTF: UIDateField!
    
    @IBOutlet weak var descriptionTV: UITextView!
    
    @IBOutlet weak var editButton: UIButton!
    
    var currentRecord:MedicalRecord!
    
    let imagePicker = UIImagePickerController()
    
    var editMode: Bool = false {
        didSet{
            if editMode == false {
      
                titleTF.isEnabled = false
                dateTF.isEnabled = false
                descriptionTV.isEditable = false
                
                editButton.setTitle("Edit Record", for: UIControlState())
                
                
                currentRecord.name = titleTF.text!
                currentRecord.date = dateTF.date
                currentRecord.notes = descriptionTV.text
                currentRecord.image = documentImage.image!
                
                self.navigationItem.title = titleTF.text!
                
    
                
            }
            if editMode == true {
                
                titleTF.isEnabled = true
                dateTF.isEnabled = true
                descriptionTV.isEditable = true
                
                editButton.setTitle("Finish Editing", for: UIControlState())

            }
        }
    }
    
    
    @IBAction func dismissKeyboard(_ sender: AnyObject) {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //set inital values
        documentImage.image = currentRecord.image
        titleTF.text = currentRecord.name
        titleTF.isEnabled = false
        
        dateTF.date = currentRecord.date
        dateTF.isEnabled = false
        
        descriptionTV.text = currentRecord.notes
        descriptionTV.isEditable = false
        
        //editButton.layer.cornerRadius = 15
        
        self.navigationItem.title = currentRecord.name
        // Do any additional setup after loading the view.
        
        
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(documentTapped))
        recognizer.delegate = self
        self.documentImage.addGestureRecognizer(recognizer)
        
        setupKeyboardNotifications()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func documentTapped() {
        if editMode {
            //stolen tobin code
            print(" ")
            let alert = UIAlertController(title: nil,
                                          message: "Would you like to take a photo with the camera, or select an existing photo from your photo library?",
                                          preferredStyle: .actionSheet)
            
            // If we have a photo in the photo view, offer an option to remove it.
            if documentImage.image != UIImage(named:"CameraIcon") {
                alert.addAction(UIAlertAction(title: "Remove Photo", style: .destructive) { action in
                    self.documentImage.image = UIImage(named:"CameraIcon")
                    })
            }
            
            // Always create an alert action option to choose the camera.
            // However, selectively disable it if a camera is not actually available on the device.
            let camera = UIAlertAction(title: "Camera", style: .default) { action in
                self.imagePicker.sourceType = .camera
                self.present(self.imagePicker, animated: true, completion: nil)
            }
            camera.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
            alert.addAction(camera)
            
            // The photo library will always exist, so we can safely add an option for it.
            alert.addAction(UIAlertAction(title: "Photo Library", style: .default) { action in
                self.imagePicker.sourceType = .photoLibrary
                self.present(self.imagePicker, animated: true, completion: nil)
                })
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        } else {
            //
            self.performSegue(withIdentifier: "presentDocumentImage", sender: self)
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? DocumentImageVC
        destination?.placeholderImage = documentImage.image
    }
    
    
    @IBAction func editButtonPressed(_ sender: UIButton) {
        if editMode {
            editMode = false
        } else {
            editMode = true 
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UserController.sharedInstance.currentRecord = self.currentRecord
        
    }
    

    
    ///////////////
    
    @IBOutlet weak var heightOfTopViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightOfTopLine: NSLayoutConstraint!
    @IBOutlet weak var heightOfBottomLine: NSLayoutConstraint!
    @IBOutlet weak var topImageConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomImageConstraint: NSLayoutConstraint!
    @IBOutlet weak var documentImageHeight: NSLayoutConstraint!
    
    //@IBOutlet weak var nextButtonToTextConstraint: NSLayoutConstraint!
    
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
            heightOfTopViewConstraint.constant = 0
            heightOfTopLine.constant = 0
            heightOfBottomLine.constant = 0
            topImageConstraint.constant = 0
            bottomImageConstraint.constant = 20
            documentImageHeight.constant = 0
            //nextButtonToTextConstraint.constant = 20
        }
        else {
            heightOfTopViewConstraint.constant = 235
            heightOfTopLine.constant = 1
            heightOfBottomLine.constant = 1
            topImageConstraint.constant = 20
            bottomImageConstraint.constant = 20
            documentImageHeight.constant = 195
            //nextButtonToTextConstraint.constant = 30
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
