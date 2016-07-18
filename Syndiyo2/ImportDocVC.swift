//
//  ImportDocVC.swift
//  Syndiyo
//
//  Created by Alan Yu on 7/18/16.
//  Copyright © 2016 Alan-Yu. All rights reserved.
//

import UIKit

class ImportDocVC: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate,UITextFieldDelegate {
    
    
    
    @IBOutlet weak var documentImage: UIImageView!
    
    @IBOutlet weak var saveButton: UIButton!

    @IBOutlet weak var selectPhotoButton: UIButton!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imagePicker.delegate = self
        imagePicker.sourceType = .PhotoLibrary
        
        documentImage.image = UIImage(named: "CameraIcon")
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(documentTapped))
        recognizer.delegate = self
        self.documentImage.addGestureRecognizer(recognizer)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func selectPhotoButtonTapped(sender: UIButton) {
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        self.documentImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func saveButtonTapped(sender: UIButton) {
    }
    
    
    func documentTapped() {
  
        if documentImage.image != UIImage(named:"CameraIcon"){
            print("presenting document")
            self.performSegueWithIdentifier("presentDocumentImage", sender: documentImage)
        }
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
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
