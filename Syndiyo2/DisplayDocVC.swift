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
      
                titleTF.enabled = false
                dateTF.enabled = false
                descriptionTV.editable = false
                
                editButton.setTitle("Edit Record", forState: .Normal)
                
                
                currentRecord.name = titleTF.text!
                currentRecord.date = dateTF.date
                currentRecord.description = descriptionTV.text
                currentRecord.image = documentImage.image!
                
                self.navigationItem.title = titleTF.text!
                
    
                
            }
            if editMode == true {
                
                titleTF.enabled = true
                dateTF.enabled = true
                descriptionTV.editable = true
                
                editButton.setTitle("Finish Editing", forState: .Normal)

            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        //set inital values
        documentImage.image = currentRecord.image
        titleTF.text = currentRecord.name
        titleTF.enabled = false
        
        dateTF.date = currentRecord.date
        dateTF.enabled = false
        
        descriptionTV.text = currentRecord.description
        descriptionTV.editable = false
        
        
        self.navigationItem.title = currentRecord.name
        // Do any additional setup after loading the view.
        
        
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(documentTapped))
        recognizer.delegate = self
        self.documentImage.addGestureRecognizer(recognizer)
        
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
        } else {
            //
            self.performSegueWithIdentifier("presentDocumentImage", sender: self)
        }
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destination = segue.destinationViewController as? DocumentImageVC
        destination?.placeholderImage = documentImage.image
    }
    
    
    @IBAction func editButtonPressed(sender: UIButton) {
        if editMode {
            editMode = false
        } else {
            editMode = true 
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        UserController.sharedInstance.currentRecord = self.currentRecord
        
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
