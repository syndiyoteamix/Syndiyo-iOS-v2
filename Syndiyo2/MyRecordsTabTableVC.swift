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
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        let nibCell = UINib(nibName: "RecordTabCustomCell", bundle: nil)
        self.tableView.registerNib(nibCell, forCellReuseIdentifier: "cell1")
        self.tableView.dataSource = self
        
        
        //disregard because there is currently no user data
        medicalRecords = UserController.sharedInstance.fakeMedicalRecords

        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        medicalRecords = UserController.sharedInstance.fakeMedicalRecords
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    
    @IBAction func doneButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func addButtonPressed(sender: UIBarButtonItem) {
        performSegueWithIdentifier("addDoc", sender: self)
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
        
        UserController.sharedInstance.currentRecord = medicalRecords[indexPath.row]
        performSegueWithIdentifier("presentDocument", sender: tableView.cellForRowAtIndexPath(indexPath))
        
        
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "presentDocument" {
            let destination = segue.destinationViewController as? DisplayDocVC
            destination?.currentRecord = UserController.sharedInstance.currentRecord
            
        }
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        UserController.sharedInstance.fakeMedicalRecords = self.medicalRecords
        UserController.sharedInstance.currentUser?.medicalRecords = self.medicalRecords
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
