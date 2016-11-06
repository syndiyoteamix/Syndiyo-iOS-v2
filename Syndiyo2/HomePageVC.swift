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
        
      
        // Do any additional setup after loading the view.
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        UserController.sharedInstance.state = .view
        
        UserController.sharedInstance.saveUsersArray()
    }
    
    @IBAction func RequestButtonPressed(_ sender: AnyObject) {
        performSegue(withIdentifier: "requestEmail", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "requestEmail" {
            let destination = segue.destination as? MyDoctorsVC
            destination?.canEditDoctor = false
            destination?.requestingInfo = true
            destination?.sendingInfo = true
            
            UserController.sharedInstance.state = .requestingDoc
        }
    }
    
    
    
    
    @IBAction func sendEmail(_ sender: AnyObject) {
        performSegue(withIdentifier: "sendEmail", sender: self)
        UserController.sharedInstance.state = .sendingDoc
        
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
