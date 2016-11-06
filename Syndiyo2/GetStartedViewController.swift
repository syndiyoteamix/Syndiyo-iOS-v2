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
        
        profilePicture.layer.cornerRadius = profilePicture.frame.size.height/2 - 17
        profilePicture.layer.masksToBounds = true
        profilePicture.layer.borderWidth = 0
      
        
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(documentTapped))
        recognizer.delegate = self
        self.profilePicture.addGestureRecognizer(recognizer)
    }
    
    @IBAction func continueButtonPressed(_ sender: AnyObject) {
        let viewController = MedicalInformationViewController(nibName: "MedicalInformationViewController", bundle: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.profilePicture.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        picker.dismiss(animated: true, completion: nil)
    }
    
    func documentTapped() {
        
        //stolen tobin code
        let alert = UIAlertController(title: nil,
                                      message: "Would you like to take a photo with the camera, or select an existing photo from your photo library?",
                                      preferredStyle: .actionSheet)
        
        // If we have a photo in the photo view, offer an option to remove it.
        if profilePicture.image != UIImage(named:"ProfileIcon") {
            alert.addAction(UIAlertAction(title: "Remove Photo", style: .destructive) { action in
                self.profilePicture.image = UIImage(named:"ProfileIcon")
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
        
    }

}
