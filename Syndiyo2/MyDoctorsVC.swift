//
//  MyDoctorsVC.swift
//  Syndiyo2
//
//  Created by Alan Yu on 7/21/16.
//  Copyright © 2016 Alan-Yu. All rights reserved.
//

import UIKit

class MyDoctorsVC: UIViewController,UITableViewDataSource, UITableViewDelegate {

    
    
    var myDoctors:[Doctor] = []
    
    var canEditDoctor:Bool = true
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        // Do any additional setup after loading the view.
        
        let doctorCell = UINib(nibName: "DoctorTableViewCell", bundle: nil)
        
        print(doctorCell)
        self.tableView.registerNib(doctorCell, forCellReuseIdentifier: "doctorCell")
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(addButtonClicked))
        
        self.navigationItem.title = "Doctors"
        self.navigationItem.rightBarButtonItem = addButton
        
        
        myDoctors = UserController.sharedInstance.currentUser!.doctorsArray!
   
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
   
    
    
    override func viewWillAppear(animated: Bool) {
        myDoctors = UserController.sharedInstance.currentUser!.doctorsArray!
        UserController.sharedInstance.saveUsersArray()
        tableView.reloadData()
        
    }
    
    
    func addButtonClicked(){
        let addDoctorsVC = AddDoctorViewController(nibName: "AddDoctorViewController", bundle: nil)
        addDoctorsVC.addingDoctor = true
        addDoctorsVC.editingDoctor = false
        self.presentViewController(addDoctorsVC, animated: true, completion: nil)
        
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myDoctors.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("doctorCell", forIndexPath: indexPath) as? DoctorTableViewCell
        
 
        print(myDoctors[indexPath.row].name)
        
        
        cell?.nameTextField.text = myDoctors[indexPath.row].name
        cell?.emailTextField.text = myDoctors[indexPath.row].email
        cell?.profilePictureImageView.image = myDoctors[indexPath.row].profilePic

        return cell!
    }
    
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            myDoctors.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            UserController.sharedInstance.currentUser?.doctorsArray = myDoctors
            UserController.sharedInstance.saveUsersArray()
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        print("hello i'm here")
        print(canEditDoctor)
        if canEditDoctor {
            print("click here yay")
            let addDoctorsVC = AddDoctorViewController(nibName: "AddDoctorViewController", bundle: nil)
            addDoctorsVC.addingDoctor = false
            addDoctorsVC.editingDoctor = true
            addDoctorsVC.currentDoctor = myDoctors[indexPath.row]
            UserController.sharedInstance.currentDoctor = myDoctors[indexPath.row]
            self.presentViewController(addDoctorsVC, animated: true, completion: nil)
            
        } else {
            
            //prepare an email to send or something
            
        }
        
        
    }

    
    
}
