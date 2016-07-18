//
//  MedicalInformation.swift
//  syndiyoInitialCode
//
//  Created by Ilham Nurjadin on 7/18/16.
//  Copyright © 2016 IlhamNurjadin. All rights reserved.
//

import Foundation

class MedicalInformation {
    
    var dob: NSDate
    var height: Int
    var weight: Int
    var allergies: [String]
    var previousMedicalConditions: [String]
    var medications: [String]
    
    init() {
        self.dob = NSDate()
        self.height = 0
        self.weight = 0
        self.allergies = [String]()
        self.previousMedicalConditions = [String]()
        self.medications = [String]()
    }
    
    init(dob: NSDate, height: Int, weight: Int, allergies: [String], previousMedicalConditions: [String], medications: [String]) {
        self.dob = dob
        self.height = height
        self.weight = weight
        self.allergies = allergies
        self.previousMedicalConditions = previousMedicalConditions
        self.medications = medications
    }
    
}