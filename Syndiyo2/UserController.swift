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
    
    
    
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    static let sharedInstance = UserController()
    var currentUser: User?
    
    var fakeMedicalRecords:[MedicalRecord] = [MedicalRecord(name: "MR1", description: "", date: NSDate(), image: UIImage(named: "CameraIcon")!),MedicalRecord(name: "Apple", description: "", date: NSDate(), image: UIImage(named:"apple")!),MedicalRecord(name: "Bird", description: "", date: NSDate(), image: UIImage(named: "angryBird")!)
    ]
    
   
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
        currentUser?.doctorsArray.appendContentsOf(doctors)
    }
    
    func deleteDoctor() {
        
    }
    
}
