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
        self.tableView.register(nibCell, forCellReuseIdentifier: "cell1")
        self.tableView.dataSource = self
        
        
        //create the buttons he needs in view
        if UserController.sharedInstance.state == .view{
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonClicked))
        
        self.navigationItem.title = "My Records"
        self.navigationItem.rightBarButtonItem = addButton
        } else if UserController.sharedInstance.state == .sendingDoc {
            let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonClicked))
            
            self.navigationItem.title = "My Records"
            self.navigationItem.rightBarButtonItem = addButton

        }
        
        
        switch UserController.sharedInstance.state {
            
        case .view:
            let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonClicked))
            
            self.navigationItem.title = "My Records"
            self.navigationItem.rightBarButtonItem = addButton
            
            
            
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonClicked))
            self.navigationItem.leftBarButtonItem = doneButton


            
        case .sendingDoc:
          
            let nextButton = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextButtonClicked))
            
            self.navigationItem.rightBarButtonItem = nextButton
            
            
            
            let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(doneButtonClicked))
            
            self.navigationItem.title = "Select Records to Send"
            self.navigationItem.leftBarButtonItem = cancelButton
   
        case .requestingDoc:
            
            break
        }
      
        
    }
    
    
    //this is an add button for when the record view is reached normally
    func addButtonClicked() {
        performSegue(withIdentifier: "addDoc", sender: self)
    }
    
    func nextButtonClicked() {
  
        performSegue(withIdentifier: "selectDoctor", sender: self)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        medicalRecords = UserController.sharedInstance.userMedicalRecords()
        self.tableView.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    
    @IBAction func doneButtonPressed(_ sender: AnyObject) {
        if sendingInfo{
            print("attempting to send info")
            var recordISend:[MedicalRecord] = []
            
            for index in recordsToSend{
                recordISend.append(medicalRecords[index])
            }
            
            UserController.sharedInstance.recordsToSend = recordISend
            self.navigationController!.popViewController(animated: true)
            
            print("what why isn't this running")
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    func doneButtonClicked (){
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        if sendingInfo {
            var recordISend:[MedicalRecord] = []
            
            for index in recordsToSend{
                recordISend.append(medicalRecords[index])
            }
            
            UserController.sharedInstance.recordsToSend = recordISend
            self.dismiss(animated: true, completion: nil)
            
        } else {
            performSegue(withIdentifier: "addDoc", sender: self)
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medicalRecords.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //check more about this code
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as? RecordTabCustomCell
        
        // Configure the cell...
        cell?.titleLabel.text = medicalRecords[indexPath.row].name
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, YYYY"
        cell?.documentImage.image = medicalRecords[indexPath.row].image
        
        
        cell?.dateLabel.text = formatter.string(from: medicalRecords[indexPath.row].date as Date)
        
        
        return cell!
    }
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            medicalRecords.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if UserController.sharedInstance.state == .sendingDoc{
            let cell = tableView.cellForRow(at: indexPath) as? RecordTabCustomCell
            if cell!.checkMarkImage.isHidden{
                // select
                cell!.checkMarkImage.isHidden = false
                
                recordsToSend.append(indexPath.row)
                
            } else {
                //deselect
                cell!.checkMarkImage.isHidden = true
                
                recordsToSend.removeFirst(indexPath.row)
            }
            
            
        } else {
            UserController.sharedInstance.currentRecord = medicalRecords[indexPath.row]
            performSegue(withIdentifier: "presentDocument", sender: tableView.cellForRow(at: indexPath))
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "presentDocument" {
            let destination = segue.destination as? DisplayDocVC
            destination?.currentRecord = UserController.sharedInstance.currentRecord
        } else if segue.identifier == "selectDoctor" {
            let destination = segue.destination as? MyDoctorsVC
            var recordISend:[MedicalRecord] = []
            
            for index in recordsToSend{
                recordISend.append(medicalRecords[index])
            }
            
            destination?.recordsToSend = recordISend
        }
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
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
