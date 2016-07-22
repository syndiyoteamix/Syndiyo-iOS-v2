//
//  GetStartedViewController.swift
//  Syndiyo2
//
//  Created by Ilham Nurjadin on 7/20/16.
//  Copyright © 2016 Alan-Yu. All rights reserved.
//

import UIKit

class GetStartedViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var continueButton: UIButton!
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self

        continueButton.layer.cornerRadius = 20
        profilePicture.layer.cornerRadius = 20
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(documentTapped))
        recognizer.delegate = self
        self.profilePicture.addGestureRecognizer(recognizer)
    }
    
    @IBAction func continueButtonPressed(sender: AnyObject) {
        let viewController = MedicalInformationViewController(nibName: "MedicalInformationViewController", bundle: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        self.profilePicture.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func documentTapped() {
        
        //stolen tobin code
        let alert = UIAlertController(title: nil,
                                      message: "Would you like to take a photo with the camera, or select an existing photo from your photo library?",
                                      preferredStyle: .ActionSheet)
        
        // If we have a photo in the photo view, offer an option to remove it.
        if profilePicture.image != UIImage(named:"ProfileIcon") {
            alert.addAction(UIAlertAction(title: "Remove Photo", style: .Destructive) { action in
                self.profilePicture.image = UIImage(named:"ProfileIcon")
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
        
    }

}
