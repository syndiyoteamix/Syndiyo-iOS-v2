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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // IM SORRY TOBIN I COULDN'T FIGURE IT OUT
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
        
        if picker.title == "frontImagePicker" {
            self.frontImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        }
        else {
            self.backImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
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
