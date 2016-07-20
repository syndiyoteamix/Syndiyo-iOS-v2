//
//  InsuranceViewController.swift
//  Syndiyo2
//
//  Created by Ilham Nurjadin on 7/19/16.
//  Copyright © 2016 Alan-Yu. All rights reserved.
//

import UIKit

class InsuranceViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate,UITextFieldDelegate {

    @IBOutlet weak var frontImage: UIImageView!
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    
    let frontImagePicker = UIImagePickerController()
    let backImagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let frontRecognizer = UITapGestureRecognizer(target: self, action: #selector(frontImageTapped))
        frontRecognizer.delegate = self
        let backRecognizer = UITapGestureRecognizer(target: self, action: #selector(backImageTapped))
        backRecognizer.delegate = self
        self.frontImage.addGestureRecognizer(frontRecognizer)
        self.backImage.addGestureRecognizer(backRecognizer)
        
        frontImage.image = UIImage(named: "CameraIcon")
        frontImage.contentMode = .Center
        backImage.image = UIImage(named: "CameraIcon")
        backImage.contentMode = .Center
        
        frontImagePicker.delegate = self
        frontImagePicker.sourceType = .PhotoLibrary
        backImagePicker.delegate = self
        backImagePicker.sourceType = .PhotoLibrary
        
        nextButton.alpha = 0.5
        nextButton.layer.cornerRadius = 5
        nextButton.enabled = false
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func frontImageTapped() {
        self.presentViewController(frontImagePicker, animated: true, completion: nil)
    }
    
    func backImageTapped() {
        self.presentViewController(backImagePicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if picker == frontImagePicker {
            if let pickedImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
                UserController.sharedInstance.currentUser?.frontInsuranceCard = pickedImage
                self.frontImage.image = pickedImage
                self.frontImage.contentMode = .ScaleAspectFit
            }
            if backImage.image != UIImage(named: "CameraIcon") {
                self.nextButton.alpha = 1
                nextButton.enabled = true
            }
        }
        else {
            if let pickedImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
                UserController.sharedInstance.currentUser?.backInsuranceCard = pickedImage
                self.backImage.image = pickedImage
                self.backImage.contentMode = .ScaleAspectFit
            }
            if frontImage.image != UIImage(named: "CameraIcon") {
                self.nextButton.alpha = 1
                nextButton.enabled = true
            }
        }
        
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MAKE SURE THAT IMAGEVIEW IS SET TO CHOSEN IMAGE

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
