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
        frontImage.contentMode = .center
        backImage.image = UIImage(named: "CameraIcon")
        backImage.contentMode = .center
        
        frontImagePicker.delegate = self
        frontImagePicker.sourceType = .photoLibrary
        backImagePicker.delegate = self
        backImagePicker.sourceType = .photoLibrary
        
        nextButton.alpha = 0.5
        nextButton.layer.cornerRadius = 5
        nextButton.isEnabled = false
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func frontImageTapped() {
        self.present(frontImagePicker, animated: true, completion: nil)
    }
    
    func backImageTapped() {
        self.present(backImagePicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if picker == frontImagePicker {
            if let pickedImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
                UserController.sharedInstance.currentUser?.frontInsuranceCard = pickedImage
                self.frontImage.image = pickedImage
                self.frontImage.contentMode = .scaleAspectFit
            }
            if backImage.image != UIImage(named: "CameraIcon") {
                self.nextButton.alpha = 1
                nextButton.isEnabled = true
            }
        }
        else {
            if let pickedImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
                UserController.sharedInstance.currentUser?.backInsuranceCard = pickedImage
                self.backImage.image = pickedImage
                self.backImage.contentMode = .scaleAspectFit
            }
            if frontImage.image != UIImage(named: "CameraIcon") {
                self.nextButton.alpha = 1
                nextButton.isEnabled = true
            }
        }
        
        picker.dismiss(animated: true, completion: nil)
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
