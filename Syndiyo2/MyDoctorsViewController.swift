//
//  MyDoctorsViewController.swift
//  Syndiyo2
//
//  Created by Alan Yu on 7/21/16.
//  Copyright © 2016 Alan-Yu. All rights reserved.
//

import UIKit

class MyDoctorsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    var myDoctors:[Doctor] = []
    
    var canEditDoctor:Bool = true
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        let doctorCell = UINib(nibName: "DoctorTableViewCell", bundle: nil)
        
        print(doctorCell)
        
        
        self.tableView.registerNib(doctorCell, forCellReuseIdentifier: "doctorCell")
        
        
     
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(addButtonClicked))
        self.navigationItem.title = "iXplore"
        self.navigationItem.rightBarButtonItem = addButton
        
        
        myDoctors = UserController.sharedInstance.currentUser!.doctorsArray!
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        myDoctors = UserController.sharedInstance.currentUser!.doctorsArray!
        tableView.reloadData()
        
    }
    
    func addButtonClicked(){
        let addDoctorsVC = AddDoctorViewController(nibName: "AddDoctorViewController", bundle: nil)
        addDoctorsVC.addingDoctor = true
        addDoctorsVC.editingDoctor = false 
        self.presentViewController(addDoctorsVC, animated: true, completion: nil)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
//        let cell = tableView.dequeueReusableCellWithIdentifier("doctorCell", forIndexPath: indexPath) as? DoctorTableViewCell
        
        // Configure the cell...
//        
//        cell?.profilePictureImageView.image = myDoctors[indexPath.row].profilePic
//        cell?.nameTextField.text = myDoctors[indexPath.row].name
//        cell?.emailTextField.text = myDoctors[indexPath.row].email
//        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            myDoctors.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if canEditDoctor {
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
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

}
