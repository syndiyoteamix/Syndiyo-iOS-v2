//
//  MyDoctorsVC.swift
//  Syndiyo2
//
//  Created by Alan Yu on 7/21/16.
//  Copyright © 2016 Alan-Yu. All rights reserved.
//

import UIKit
import MessageUI


class MyDoctorsVC: UIViewController,UITableViewDataSource, UITableViewDelegate,MFMailComposeViewControllerDelegate, UITextFieldDelegate {

    
    
    var myDoctors:[Doctor] = []
    
    var canEditDoctor:Bool = true
    
    var requestingInfo: Bool = false
    var requestEmail:String?
    var requestText:String = "I, \(UserController.sharedInstance.currentUser!.firstName) \(UserController.sharedInstance.currentUser!.lastName) , hereby request my Health Records." + "\n\n" + "This request is for any and all medical records related to services provided, and may include but not limited to Clinic Notes, Laboratory Reports, Radiology Reports, X-Ray Film/Images, EKG, History & Physical Exam, Discharge Summary, Progress Notes, Consultation Report, Specialist Notes, Department Record, Billing Record or any other documents belonging to Patient's medical records." + "\n\n" + "I understand that I have a right to receive a copy of my health information under the Health Insurance Portability and Accountability Act of 1996. Please consider this notification my official request in writing for my health information. The purpose for the release of health information is for archiving and personal use only."
    
    
    var sendingInfo:Bool = false
    var sendingEmail:String?
    
    
    var sendingText:String = "I, \(UserController.sharedInstance.currentUser!.firstName) \(UserController.sharedInstance.currentUser!.lastName) am hereby sending the attached medical record(s) for my next appointment."
    
    var recordsToSend:[MedicalRecord]?
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
      
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        // Do any additional setup after loading the view.
        
        let doctorCell = UINib(nibName: "DoctorTableViewCell", bundle: nil)
        
        print(doctorCell)
        self.tableView.registerNib(doctorCell, forCellReuseIdentifier: "doctorCell")
        
        if canEditDoctor {
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(addButtonClicked))
        
        self.navigationItem.title = "Doctors"
        self.navigationItem.rightBarButtonItem = addButton
        }
        
        if sendingInfo {
            let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(sendEmail))
            
            self.navigationItem.title = "Doctors"
            self.navigationItem.rightBarButtonItem = addButton
        }
        
        myDoctors = UserController.sharedInstance.currentUser!.doctorsArray!
   
        
        
        switch UserController.sharedInstance.state {
        case .view:
            let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(addButtonClicked))
            
            self.navigationItem.title = "My Doctors"
            self.navigationItem.rightBarButtonItem = addButton
            
        case .requestingDoc:
            
            let sendButton = UIBarButtonItem(title: "Send", style: .Plain, target: self, action: #selector(sendButtonPressed))
            
            self.navigationItem.title = "Select Doctor"
            self.navigationItem.rightBarButtonItem = sendButton

        case .sendingDoc:
            
            let sendDocButton = UIBarButtonItem(title: "Send", style: .Plain, target: self, action: #selector(sendEmail))
            
            self.navigationItem.title = "Select Doctor"
            self.navigationItem.rightBarButtonItem = sendDocButton
        
        }
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //send request
    func sendButtonPressed() {
        let mailComposerVC = MFMailComposeViewController()
        
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients([sendingEmail!])
        mailComposerVC.setSubject("Medical Record Request")
        mailComposerVC.setMessageBody(requestText, isHTML: false)
        
    
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposerVC, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }

        
    }
    
    //send Records
    func sendEmail (){
        let mailComposerVC = MFMailComposeViewController()
    
        
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients([sendingEmail!])
        mailComposerVC.setSubject("Medical Record for Next Appointment")
        mailComposerVC.setMessageBody(sendingText, isHTML: false)
        
     
        for record in recordsToSend!{
            let imageData: NSData = UIImagePNGRepresentation(record.image)!
            mailComposerVC.addAttachmentData(imageData, mimeType: "image/png" , fileName: record.name)
        }
        
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposerVC, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        myDoctors = UserController.sharedInstance.currentUser!.doctorsArray!
        tableView.reloadData()
    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        UserController.sharedInstance.saveUsersArray()
        recordsToSend = UserController.sharedInstance.recordsToSend
    }
    
    
    //add doctor view controller pops up
    func addButtonClicked(){
        let addDoctorsVC = AddDoctorViewController(nibName: "AddDoctorViewController", bundle: nil)
        
        addDoctorsVC.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        self.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
    
        
        self.definesPresentationContext = true
        addDoctorsVC.addingDoctor = true
        addDoctorsVC.editingDoctor = false
        self.presentViewController(addDoctorsVC, animated: true, completion: nil)
    }
    
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        
        if requestingInfo {
        
//        mailComposerVC.mailComposeDelegate = self
//        mailComposerVC.setToRecipients([requestEmail!])
//        mailComposerVC.setSubject("Medical Record Request")
//        mailComposerVC.setMessageBody(requestText, isHTML: false)
        }
        
        if sendingInfo {
            mailComposerVC.mailComposeDelegate = self
            mailComposerVC.setToRecipients([sendingEmail!])
            mailComposerVC.setSubject("Medical Record for Next Appointment")
            mailComposerVC.setMessageBody(sendingText, isHTML: false)
            
            
            
            for record in recordsToSend!{
                let imageData: NSData = UIImagePNGRepresentation(record.image)!
                mailComposerVC.addAttachmentData(imageData, mimeType: "image/png" , fileName: record.name)
            }
     
            
        }
        
        
        return mailComposerVC
    }
    
    
    func showSendMailErrorAlert() {
        // update code here later
        let sendMailErrorAlert = UIAlertView(title: "Error", message: "Could not send email, please check email configuration", delegate: self, cancelButtonTitle: "Ok")
        sendMailErrorAlert.show()
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        
        controller.dismissViewControllerAnimated(true, completion: nil)
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
            
            
            self.navigationController!.popViewControllerAnimated(true)
            
        } else if requestingInfo{
            let email:String = myDoctors[indexPath.row].email
            print(email)
            
            let mailComposerVC = MFMailComposeViewController()
            mailComposerVC.mailComposeDelegate = self
            mailComposerVC.setToRecipients([email])
            mailComposerVC.setSubject("Medical Record Request")
            mailComposerVC.setMessageBody(requestText, isHTML: false)
            
            
            
            
            
           // let mailComposeViewController = configuredMailComposeViewController()
            if MFMailComposeViewController.canSendMail() {
                self.presentViewController(mailComposerVC, animated: true, completion: nil)
            } else {
                self.showSendMailErrorAlert()
            }
    
        } else if sendingInfo {
            sendingEmail = myDoctors[indexPath.row].email
            
            
            performSegueWithIdentifier("selectRecords", sender: self)
            
        }
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destination = segue.destinationViewController as? MyRecordsTabTableVC
        destination?.sendingInfo = true
    }
    
    
    
    @IBAction func doneButtonPressed(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
}
