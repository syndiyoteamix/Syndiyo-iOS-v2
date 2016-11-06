//
//  CustomRequestVC.swift
//  Syndiyo2
//
//  Created by Alan Yu on 7/19/16.
//  Copyright © 2016 Alan-Yu. All rights reserved.
//

import UIKit
import MessageUI

class CustomRequestVC: UIViewController,MFMailComposeViewControllerDelegate, UITextFieldDelegate{
    
    
    @IBOutlet weak var doctorEmailTextField: UITextField!
    
    
    @IBOutlet weak var subjectTextField: UITextField!
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SendButtonTapped(_ sender: AnyObject) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["alejandro@ixperience.co.za"])
        mailComposerVC.setSubject("hello")
        mailComposerVC.setMessageBody(textView.text!, isHTML: false)
        
        return mailComposerVC
    }
    
    
    func showSendMailErrorAlert() {
        // update code here later
        let sendMailErrorAlert = UIAlertView(title: "Error", message: "Could not send email, please check email configuration", delegate: self, cancelButtonTitle: "Ok")
        sendMailErrorAlert.show()
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
   
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func doctorEmailPrimaryAction(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func emailSubjectPrimaryAction(_ sender: UITextField) {
        sender.resignFirstResponder()
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
