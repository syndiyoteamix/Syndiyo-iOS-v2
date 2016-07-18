//
//  UserController.swift
//  Syndiyo
//
//  Created by Ilham Nurjadin on 7/18/16.
//  Copyright © 2016 Alan-Yu. All rights reserved.
//

import Foundation

class UserController {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    static let sharedInstance = UserController()
    var currentUser: User?
    
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