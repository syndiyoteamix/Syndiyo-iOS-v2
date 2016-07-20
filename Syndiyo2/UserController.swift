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
    var currentRecord:MedicalRecord? 
    
    
    
    
    
    var fakeMedicalRecords:[MedicalRecord] = [MedicalRecord(name: "MR1", description: "", date: NSDate(), image: UIImage(named: "CameraIcon")!,category:"Medical"),MedicalRecord(name: "Apple", description: "", date: NSDate(), image: UIImage(named:"apple")!,category:"Medical"),MedicalRecord(name: "Bird", description: "", date: NSDate(), image: UIImage(named: "angryBird")!,category:"Medical")]
    var users: [User] = [User]()
    
    
    func checkUsernameAvailability(email: String) -> Bool {
        for person in users {
            if person.email == email { return false }
        }
        return true
    }
    
    
    
    func registerUser(onCompletion: (String?) -> Void) {
        if currentUser != nil {
            users.append(currentUser!)
            onCompletion(nil)
            let documents = manager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
            let fileURL = documents.URLByAppendingPathComponent("users.txt")
            
            NSKeyedArchiver.archiveRootObject(users, toFile: fileURL.path!)
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
   
    func addMedicalRecord(record:MedicalRecord){
        //currentUser?.medicalRecords?.append(record)
        fakeMedicalRecords.append(record)
    }
    
    
    func userMedicalRecords() -> [MedicalRecord]{
        
        return fakeMedicalRecords
    }
    
    func updateUserInfo() {
        
    }
    
    func updateMedicalInformation(medicalInfo: MedicalInformation) {
        
    }
    
    func addDoctors(doctors: [Doctor]) {
        currentUser?.doctorsArray!.appendContentsOf(doctors)
    }
    
    func deleteDoctor() {
        
    }
    
}
