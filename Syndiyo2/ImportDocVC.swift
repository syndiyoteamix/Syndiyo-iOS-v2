//
//  ImportDocVC.swift
//  Syndiyo
//
//  Created by Alan Yu on 7/18/16.
//  Copyright © 2016 Alan-Yu. All rights reserved.
//

import UIKit

class ImportDocVC: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
    
    @IBOutlet weak var documentImage: UIImageView!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var titleTextBox: UITextField!
    
    @IBOutlet weak var dateTextBox: UIDateField!
    
    @IBOutlet weak var categoryType: UISelectionField!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imagePicker.delegate = self
        imagePicker.sourceType = .PhotoLibrary
        
        documentImage.image = UIImage(named: "GoodCamera")
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(documentTapped))
        recognizer.delegate = self
        self.documentImage.addGestureRecognizer(recognizer)
        
        //set categories 
        categoryType.options = ["Medical"," Immunization", "Prescription", "Dental Vision Laboratory Radiology", "Genetic Data", "Biometric Data", "Blood Pressure", "Blood Sugar", "eRecords", "BlueButton+", "Billing"]
        categoryType.text = ""
        
        setupKeyboardNotifications()
        
    }

    @IBAction func dismissKeyboard(sender: AnyObject) {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    
    
//    @IBAction func selectPhotoButtonTapped(sender: UIButton) {
//        
//        //stolen tobin code
//        let alert = UIAlertController(title: nil,
//                                      message: "Would you like to take a photo with the camera, or select an existing photo from your photo library?",
//                                      preferredStyle: .ActionSheet)
//        
//        // If we have a photo in the photo view, offer an option to remove it.
//        if documentImage.image != UIImage(named:"CameraIcon") {
//            alert.addAction(UIAlertAction(title: "Remove Photo", style: .Destructive) { action in
//                self.documentImage.image = UIImage(named:"CameraIcon")
//                })
//        }
//        
//        // Always create an alert action option to choose the camera.
//        // However, selectively disable it if a camera is not actually available on the device.
//        let camera = UIAlertAction(title: "Camera", style: .Default) { action in
//            self.imagePicker.sourceType = .Camera
//            self.presentViewController(self.imagePicker, animated: true, completion: nil)
//        }
//        camera.enabled = UIImagePickerController.isSourceTypeAvailable(.Camera)
//        alert.addAction(camera)
//        
//        // The photo library will always exist, so we can safely add an option for it.
//        alert.addAction(UIAlertAction(title: "Photo Library", style: .Default) { action in
//            self.imagePicker.sourceType = .PhotoLibrary
//            self.presentViewController(self.imagePicker, animated: true, completion: nil)
//            })
//        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
//        
//        self.presentViewController(alert, animated: true, completion: nil)
//        
//    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        self.documentImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func saveButtonTapped(sender: UIButton) {
        print("saveButtonTapped")
        //create a catch if there is no image or no record
        let newRecord = MedicalRecord(name:titleTextBox.text!, notes: "", date: dateTextBox.date, image: documentImage.image!,category: categoryType.text!)
        UserController.sharedInstance.addMedicalRecord(newRecord)
        
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    
    func documentTapped() {
        
        //stolen tobin code
        let alert = UIAlertController(title: nil,
                                      message: "Would you like to take a photo with the camera, or select an existing photo from your photo library?",
                                      preferredStyle: .ActionSheet)
        
        // If we have a photo in the photo view, offer an option to remove it.
        if documentImage.image != UIImage(named:"CameraIcon") {
            alert.addAction(UIAlertAction(title: "Remove Photo", style: .Destructive) { action in
                self.documentImage.image = UIImage(named:"CameraIcon")
                })
        }
        
        // Always create an alert action option to choose the camera.
        // However, selectively disable it if a camera is not actually available on the device.
        let camera = UIAlertAction(title: "Camera", style: .Default) { action in
            self.imagePicker.sourceType = .Camera
            self.presentViewController(self.imagePicker, animated: true, completion: nil)
        }
        camera.enabled = UIImagePickerController.isSourceTypeAvailable(.Camera)
        alert.addAction(camera)
        
        // The photo library will always exist, so we can safely add an option for it.
        alert.addAction(UIAlertAction(title: "Photo Library", style: .Default) { action in
            self.imagePicker.sourceType = .PhotoLibrary
            self.presentViewController(self.imagePicker, animated: true, completion: nil)
            })
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
        
        
//        if documentImage.image != UIImage(named:"CameraIcon"){
//            print("presenting document")
//            self.performSegueWithIdentifier("presentDocumentImage", sender: documentImage)
//        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "presentDocumentImage"){
            let destination = segue.destinationViewController as? DocumentImageVC
            destination?.placeholderImage = documentImage.image
        }
    }
    
    
    
    @IBAction func titleFieldPrimaryActionTriggered(sender: AnyObject) {
        sender.resignFirstResponder()
    }
    
    
    
    ///////////////
    
    @IBOutlet weak var heightOfTopViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightOfTopLine: NSLayoutConstraint!
    @IBOutlet weak var heightOfBottomLine: NSLayoutConstraint!
    @IBOutlet weak var topImageConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomImageConstraint: NSLayoutConstraint!
    //@IBOutlet weak var nextButtonToTextConstraint: NSLayoutConstraint!
    
    func keyboardWillShow(notification: NSNotification) {
        
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue()
            let duration:NSTimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.unsignedLongValue ?? UIViewAnimationOptions.CurveEaseInOut.rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            
            //if the phone is < 5, then the keyboard will overlay the textfields when it comes up. accomodate for
            self.updateUIForKeyboard(endFrame,keyboardDirectionUp:true)
            
            UIView.animateWithDuration(duration,
                                       delay: NSTimeInterval(0),
                                       options: animationCurve,
                                       animations: {
                                        self.view.layoutIfNeeded()
                },
                                       completion: nil)
        }
    }
    
    
    func updateUIForKeyboard(endFrame:CGRect!, keyboardDirectionUp:Bool)  {
        if (keyboardDirectionUp) {
            heightOfTopViewConstraint.constant = 100
            heightOfTopLine.constant = 1
            heightOfBottomLine.constant = 1
            topImageConstraint.constant = 20
            bottomImageConstraint.constant = 20
            //nextButtonToTextConstraint.constant = 20
        }
        else {
            heightOfTopViewConstraint.constant = 235
            heightOfTopLine.constant = 1
            heightOfBottomLine.constant = 1
            topImageConstraint.constant = 20
            bottomImageConstraint.constant = 20
            //nextButtonToTextConstraint.constant = 30
        } //the original value from the nib
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue()
            let duration:NSTimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.unsignedLongValue ?? UIViewAnimationOptions.CurveEaseInOut.rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            
            self.view.endEditing(true);
            self.resignFirstResponder()
            //reset the frame to 0;0
            var newFrame = self.view.frame
            newFrame.origin.y = 0
            newFrame.size.height = UIScreen.mainScreen().bounds.height
            self.view.frame = newFrame
            
            self.updateUIForKeyboard(endFrame, keyboardDirectionUp:false)
            
            //do the animation
            UIView.animateWithDuration(duration,
                                       
                                       delay: NSTimeInterval(0),
                                       options: animationCurve,
                                       animations: {
                                        self.view.layoutIfNeeded()
                },
                                       completion: nil)
        }
        
    }
    

}
