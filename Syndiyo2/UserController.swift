//
//  UserController.swift
//  Syndiyo
//
//  Created by Ilham Nurjadin on 7/18/16.
//  Copyright © 2016 Alan-Yu. All rights reserved.
//

import Foundation
import UIKit

class UserController {
    
    let manager = NSFileManager.defaultManager()
    
    static let sharedInstance = UserController()
    
    
    
    
    var currentUser: User?
    var currentRecord: MedicalRecord?
    var currentDoctor: Doctor?
    
    var fakeDoctors:[Doctor] = [Doctor(name: "BS1", speciality: "", address: "", email: "BS1@gmail.com", fax: "", phone: "", profilePic: nil), Doctor(name: "BS2", speciality: "", address: "", email: "", fax: "", phone: "", profilePic: nil)]
    
    
    
    
    var fakeMedicalRecords:[MedicalRecord] = [MedicalRecord(name: "MR1", notes: "", date: NSDate(), image: UIImage(named: "CameraIcon")!,category:"Medical"),MedicalRecord(name: "Apple", notes: "", date: NSDate(), image: UIImage(named:"apple")!,category:"Medical"),MedicalRecord(name: "Bird", notes: "", date: NSDate(), image: UIImage(named: "angryBird")!,category:"Medical")]
   
    var users: [User] = [User]()
    
    var recordsToSend:[MedicalRecord]?

    
    func updateUsersArray() {
        for user in users{
            if user.ID == currentUser!.ID {
                let index:Int = users.indexOf(user)!
                users.removeAtIndex(index)
                users.insert(currentUser!, atIndex: index)
                saveUsersArray()
            }
        }
    }
    
    
    
    func registerUser(onCompletion: (String?) -> Void) {
        if currentUser != nil {
            users.append(currentUser!)
            onCompletion(nil)
            saveUsersArray()
            print("yo")
        }
        // if CurrentUser is nil
        else { onCompletion("Could not register user") }
    }
    
    
    func loginUser(email: String, password: String, onCompletion: (User?, String?) -> Void) {
        if users.isEmpty {
            print("hey")
            onCompletion(nil, "Email or password is incorrect")
        }
        for person in users {
            if person.email == email && person.password == password {
                onCompletion(person, nil)
            }
            else {
                onCompletion(nil, "Email or password is incorrect")
            }
        }
    }
    
    
    func checkUsernameAvailability(email: String) -> Bool {
        for person in users {
            if person.email == email { return false }
        }
        return true
    }
   
    
    func saveUsersArray(){
        let documents = manager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        let fileURL = documents.URLByAppendingPathComponent("users.txt")
        
        NSKeyedArchiver.archiveRootObject(users, toFile: fileURL.path!)
    }
    
    
    func addMedicalRecord(record:MedicalRecord){
        currentUser?.medicalRecords?.append(record)
     //   fakeMedicalRecords.append(record)
    }
    
    func userMedicalRecords() -> [MedicalRecord]{
        return currentUser!.medicalRecords!
    }
    
    
    func updateUserInfo() {
        
    }
    
    func updateMedicalInformation(medicalInfo: MedicalInformation) {
        
    }
    
    func addDoctors(doctors: [Doctor]) {
        currentUser?.doctorsArray!.appendContentsOf(doctors)
    }
    
    func updateDoctorsArray() {
        for doct in currentUser!.doctorsArray! {
            if doct.UUID == currentDoctor!.UUID {
                let index = currentUser!.doctorsArray!.indexOf(doct)!
                currentUser?.doctorsArray!.removeAtIndex(index)
                currentUser?.doctorsArray!.insert(doct, atIndex: index)
            }
        }
    }
    
    func deleteDoctor() {
        
    }
    
}
