//
//  HomePageVC.swift
//  Syndiyo
//
//  Created by Alan Yu on 7/18/16.
//  Copyright © 2016 Alan-Yu. All rights reserved.
//

import UIKit

class HomePageVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserController.sharedInstance.saveUsersArray()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func RequestButtonPressed(sender: AnyObject) {
        performSegueWithIdentifier("requestEmail", sender: self)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "requestEmail" {
            let destination = segue.destinationViewController as? MyDoctorsVC
            destination?.canEditDoctor = false
            destination?.requestingInfo = true
            destination?.sendingInfo = true
        }
        if segue.identifier == "sendEmail" {
            if let destination = segue.destinationViewController as? UINavigationController{
                if let root = destination.viewControllers[0] as? MyDoctorsVC{
                    root.canEditDoctor = false
                    root.requestingInfo = false
                    root.sendingInfo = true
                }
            }
        }
    }
    
    
    
    
    @IBAction func sendEmail(sender: AnyObject) {
        performSegueWithIdentifier("sendEmail", sender: self)

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
