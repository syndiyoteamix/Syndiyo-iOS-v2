//
//  MyDoctorsVC.swift
//  Syndiyo2
//
//  Created by Alan Yu on 7/21/16.
//  Copyright © 2016 Alan-Yu. All rights reserved.
//

import UIKit
import MessageUI


class MyDoctorsVC: UIViewController,UITableViewDataSource, UITableViewDelegate,MFMailComposeViewControllerDelegate, UITextFieldDelegate,AddDoctorDelegate {

    
    
    var myDoctors:[Doctor] = []
    
    var canEditDoctor:Bool = true
    
    var requestingInfo: Bool = false
    var requestEmail:String = ""
    var requestText:String = "I, \(UserController.sharedInstance.currentUser!.firstName) \(UserController.sharedInstance.currentUser!.lastName) , hereby request my Health Records." + "\n\n" + "This request is for any and all medical records related to services provided, and may include but not limited to Clinic Notes, Laboratory Reports, Radiology Reports, X-Ray Film/Images, EKG, History & Physical Exam, Discharge Summary, Progress Notes, Consultation Report, Specialist Notes, Department Record, Billing Record or any other documents belonging to Patient's medical records." + "\n\n" + "I understand that I have a right to receive a copy of my health information under the Health Insurance Portability and Accountability Act of 1996. Please consider this notification my official request in writing for my health information. The purpose for the release of health information is for archiving and personal use only."
    
    
    var sendingInfo:Bool = false
    var sendingEmail:String = ""
    
    
    var sendingText:String = "I, \(UserController.sharedInstance.currentUser!.firstName) \(UserController.sharedInstance.currentUser!.lastName) am hereby sending the attached medical record(s) for my next appointment."
    
    var recordsToSend:[MedicalRecord] = []
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var greyView: UIView!
    
    
    
    override func viewDidLoad() {
      
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        // Do any additional setup after loading the view.
        
        let doctorCell = UINib(nibName: "DoctorTableViewCell", bundle: nil)
        
        print(doctorCell)
        self.tableView.register(doctorCell, forCellReuseIdentifier: "doctorCell")
        
        if canEditDoctor {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonClicked))
        
        self.navigationItem.title = "Doctors"
        self.navigationItem.rightBarButtonItem = addButton
        }
        
        
        myDoctors = UserController.sharedInstance.currentUser!.doctorsArray!
   
        
        
        switch UserController.sharedInstance.state {
        case .view:
            let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonClicked))
            
            self.navigationItem.title = "My Doctors"
            self.navigationItem.rightBarButtonItem = addButton
            
        case .requestingDoc:
            
            let sendButton = UIBarButtonItem(title: "Send", style: .plain, target: self, action: #selector(sendButtonPressed))
            
            
            let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonClicked))
            
            self.navigationItem.title = "Select Doctor"
            self.navigationItem.rightBarButtonItem = sendButton
            self.navigationItem.leftBarButtonItem = cancelButton

        case .sendingDoc:
            
            let sendDocButton = UIBarButtonItem(title: "Send", style: .plain, target: self, action: #selector(sendEmail))
            
            let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonPressed))
            
            self.navigationItem.title = "Select Doctor"
            self.navigationItem.rightBarButtonItem = sendDocButton
            self.navigationItem.leftBarButtonItem = backButton
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UserController.sharedInstance.saveUsersArray()
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        myDoctors = UserController.sharedInstance.currentUser!.doctorsArray!
        tableView.reloadData()
    }
    
    
    func didDisappear() {
        
        greyView.isHidden = true
        myDoctors = UserController.sharedInstance.currentUser!.doctorsArray!
        tableView.reloadData()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonClicked))
        
        self.navigationItem.title = "My Doctors"
        self.navigationItem.rightBarButtonItem = addButton
        self.navigationItem.leftBarButtonItem = nil
        
    }
    
    func cancelButtonClicked(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //send request
    func sendButtonPressed() {
        let mailComposerVC = MFMailComposeViewController()
        
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients([requestEmail])
        mailComposerVC.setSubject("Medical Record Request")
        mailComposerVC.setMessageBody(requestText, isHTML: false)
        
    
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposerVC, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }

        
    }
    
    //send Records
    func sendEmail (){
        let mailComposerVC = MFMailComposeViewController()
    
        
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients([sendingEmail])
        mailComposerVC.setSubject("Medical Record for Next Appointment")
        mailComposerVC.setMessageBody(sendingText, isHTML: false)
        
     
        for record in recordsToSend{
            let imageData: Data = UIImagePNGRepresentation(record.image)!
            mailComposerVC.addAttachmentData(imageData, mimeType: "image/png" , fileName: record.name)
        }
        
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposerVC, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    
    
   
    
    
   
    
    //add doctor view controller pops up
    func addButtonClicked(){
        
        
        greyView.isHidden = false
        
        
        // change the navi bar 
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonClicked))
        self.navigationItem.title = "Add a New Doctor"
        self.navigationItem.rightBarButtonItem = nil
        self.navigationItem.leftBarButtonItem = cancelButton
        
        
        //present the vc
        let addDoctorsVC = AddDoctorViewController(nibName: "AddDoctorViewController", bundle: nil)
        
        addDoctorsVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
    
        
        self.definesPresentationContext = true
        addDoctorsVC.addingDoctor = true
        addDoctorsVC.editingDoctor = false
        addDoctorsVC.delegate = self
        self.present(addDoctorsVC, animated: true, completion: nil)
    }
    
    
    func showSendMailErrorAlert() {
        // update code here later
        let sendMailErrorAlert = UIAlertView(title: "Error", message: "Could not send email, please check email configuration", delegate: self, cancelButtonTitle: "Ok")
        sendMailErrorAlert.show()
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        UserController.sharedInstance.state = .view
        controller.dismiss(animated: true, completion: nil)
   
    }

    
  
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myDoctors.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "doctorCell", for: indexPath) as? DoctorTableViewCell
        cell?.nameTextField.text = myDoctors[indexPath.row].name
        cell?.emailTextField.text = myDoctors[indexPath.row].email
        cell?.profilePictureImageView.image = myDoctors[indexPath.row].profilePic

        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            myDoctors.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            UserController.sharedInstance.currentUser?.doctorsArray = myDoctors
            UserController.sharedInstance.saveUsersArray()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        switch UserController.sharedInstance.state {
        case .view:
            
            
            greyView.isHidden = false
            
            
            //change the navi bar
            
            let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonClicked))
            self.navigationItem.title = "Edit a doctor"
            self.navigationItem.rightBarButtonItem = nil
            self.navigationItem.leftBarButtonItem = cancelButton
            
            
            
            //present the view
            let addDoctorsVC = AddDoctorViewController(nibName: "AddDoctorViewController", bundle: nil)
            
            addDoctorsVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            self.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            
            addDoctorsVC.addingDoctor = false
            addDoctorsVC.editingDoctor = true
            addDoctorsVC.delegate = self
            addDoctorsVC.currentDoctor = myDoctors[indexPath.row]
            UserController.sharedInstance.currentDoctor = myDoctors[indexPath.row]
        
            
            
            self.definesPresentationContext = true
            self.present(addDoctorsVC, animated: true, completion: nil)

        case .requestingDoc:
            requestEmail = myDoctors[indexPath.row].email
            
            
        case .sendingDoc:
            sendingEmail = myDoctors[indexPath.row].email
            
   
        }
        
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? MyRecordsTabTableVC
        destination?.sendingInfo = true
    }
    
    
    
    
}
