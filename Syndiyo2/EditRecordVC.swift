//
//  DisplayRecordVC.swift
//  Syndiyo2
//
//  Created by Alan Yu on 7/19/16.
//  Copyright © 2016 Alan-Yu. All rights reserved.
//

import UIKit

class EditRecordVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
    
    @IBOutlet weak var documentImageView: UIImageView!
    
    @IBOutlet weak var titleTF: UITextField!
    
    @IBOutlet weak var dateTF: UITextField!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var editButton: UIButton!
    
    let imagePicker = UIImagePickerController()
    
    var editMode:Bool = false 
    
    var documentImageHolder:UIImage?
    var titleHolder:String?
    var dateHolder: String?
    var descriptionHolder: String?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTF.text = titleHolder
        dateTF.text = dateHolder
        documentImageView.image = documentImageHolder
        descriptionTextView.text = descriptionHolder

        // Do any additional setup after loading the view.
        
        
        //set image picker
        imagePicker.delegate = self
        imagePicker.sourceType = .PhotoLibrary
        
        //add a gesture Recognizer
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(documentTapped))
        recognizer.delegate = self
        self.documentImageView.addGestureRecognizer(recognizer)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func editButtonPressed(sender: UIButton) {
        
        if editMode {
            //edit mode is true
            editButton.setTitle("Edit Record", forState: .Normal)
            titleTF.allowsEditingTextAttributes = true
            dateTF.allowsEditingTextAttributes = true
            descriptionTextView.allowsEditingTextAttributes = true
            editMode = false
            
        } else {
            //edit mode is false
            editButton.setTitle("Finish Editing", forState: .Normal)
            
            titleTF.allowsEditingTextAttributes = false
            dateTF.allowsEditingTextAttributes = false
            descriptionTextView.allowsEditingTextAttributes = false
            editMode = true
            
        }
        
    }
    
    
    
    func documentTapped(){
        //there are two segues, if edit mode is true, go to camera role, else display the image in a image display
        if editMode {
            // go to camera role to select a new photo
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }else {
            // go view an image!
            
            
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        self.documentImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        picker.dismissViewControllerAnimated(true, completion: nil)
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
