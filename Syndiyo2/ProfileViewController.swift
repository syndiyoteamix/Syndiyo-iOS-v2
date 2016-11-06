//
//  ProfileViewController.swift
//  Syndiyo2
//
//  Created by Ilham Nurjadin on 7/22/16.
//  Copyright © 2016 Alan-Yu. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profilePicture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profilePicture.layer.cornerRadius = profilePicture.frame.size.height/2 - 17
        profilePicture.layer.masksToBounds = true
        profilePicture.layer.borderWidth = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutButtonClicked(_ sender: AnyObject) {
        
        UserController.sharedInstance.saveUsersArray()
        UserController.sharedInstance.currentUser = nil
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController()
        let application = UIApplication.shared
        let window = application.keyWindow
        window?.rootViewController = viewController
        
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
