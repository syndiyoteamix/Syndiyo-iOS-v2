//
//  MyRecordsTabTableVC.swift
//  Syndiyo2
//
//  Created by Alan Yu on 7/18/16.
//  Copyright © 2016 Alan-Yu. All rights reserved.
//

import UIKit

class MyRecordsTabTableVC: UITableViewController{
    
    
    //fake info for shit
    var medicalRecords:[MedicalRecord] = []
    
    var sendingInfo:Bool = false
    
    var recordsToSend:[Int] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        //set the nib cell
        let nibCell = UINib(nibName: "RecordTabCustomCell", bundle: nil)
        self.tableView.registerNib(nibCell, forCellReuseIdentifier: "cell1")
        self.tableView.dataSource = self
        
        
        //create the buttons he needs in view
        if UserController.sharedInstance.state == .view{
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(addButtonClicked))
        
        self.navigationItem.title = "My Records"
        self.navigationItem.rightBarButtonItem = addButton
        } else if UserController.sharedInstance.state == .sendingDoc {
            let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(addButtonClicked))
            
            self.navigationItem.title = "My Records"
            self.navigationItem.rightBarButtonItem = addButton

        }
      
        
    }
    
    
    //this is an add button for when the record view is reached normally
    func addButtonClicked() {
        performSegueWithIdentifier("addDoc", sender: self)
       
    }
    
    
    
    
    override func viewWillAppear(animated: Bool) {
        medicalRecords = UserController.sharedInstance.userMedicalRecords()
        self.tableView.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    
    @IBAction func doneButtonPressed(sender: AnyObject) {
        if sendingInfo{
            print("attempting to send info")
            var recordISend:[MedicalRecord] = []
            
            for index in recordsToSend{
                recordISend.append(medicalRecords[index])
            }
            
            UserController.sharedInstance.recordsToSend = recordISend
            self.navigationController!.popViewControllerAnimated(true)
            
            print("what why isn't this running")
        } else {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    
    @IBAction func addButtonPressed(sender: UIBarButtonItem) {
        if sendingInfo {
            var recordISend:[MedicalRecord] = []
            
            for index in recordsToSend{
                recordISend.append(medicalRecords[index])
            }
            
            UserController.sharedInstance.recordsToSend = recordISend
            self.dismissViewControllerAnimated(true, completion: nil)
            
        } else {
            performSegueWithIdentifier("addDoc", sender: self)
        }
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medicalRecords.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //check more about this code
        let cell = tableView.dequeueReusableCellWithIdentifier("cell1") as? RecordTabCustomCell
        
        // Configure the cell...
        cell?.titleLabel.text = medicalRecords[indexPath.row].name
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MMMM d, YYYY"
        cell?.documentImage.image = medicalRecords[indexPath.row].image
        
        
        cell?.dateLabel.text = formatter.stringFromDate(medicalRecords[indexPath.row].date)
        
        
        return cell!
    }
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            medicalRecords.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if sendingInfo{
            let cell = tableView.cellForRowAtIndexPath(indexPath) as? RecordTabCustomCell
            if cell!.checkMarkImage.hidden{
                // select
                cell!.checkMarkImage.hidden = false
                
                recordsToSend.append(indexPath.row)
                
            } else {
                //deselect
                cell!.checkMarkImage.hidden = true
                
                recordsToSend.removeFirst(indexPath.row)
            }
            
            
        } else {
            UserController.sharedInstance.currentRecord = medicalRecords[indexPath.row]
            performSegueWithIdentifier("presentDocument", sender: tableView.cellForRowAtIndexPath(indexPath))
        }
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "presentDocument" {
            let destination = segue.destinationViewController as? DisplayDocVC
            destination?.currentRecord = UserController.sharedInstance.currentRecord
            
        }
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        if !sendingInfo{
            //UserController.sharedInstance.fakeMedicalRecords = self.medicalRecords
            UserController.sharedInstance.currentUser?.medicalRecords = self.medicalRecords
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
