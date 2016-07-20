//
//  MedicalInformation.swift
//  syndiyoInitialCode
//
//  Created by Ilham Nurjadin on 7/18/16.
//  Copyright © 2016 IlhamNurjadin. All rights reserved.
//

import Foundation

class MedicalInformation: NSObject, NSCoding {
    
    var dob: NSDate?
    var height: String?
    var weight: String?
    var allergies: String?
    var previousMedicalConditions: String?
    var medications: String?
    
//    init() {
//        self.dob = NSDate()
//        self.height = 0
//        self.weight = 0
//        self.allergies = [String]()
//        self.previousMedicalConditions = [String]()
//        self.medications = [String]()
//    }
    
    init(dob: NSDate?, height: String?, weight: String?, allergies: String?, previousMedicalConditions: String?, medications: String?) {
        self.dob = dob
        self.height = height
        self.weight = weight
        self.allergies = allergies
        self.previousMedicalConditions = previousMedicalConditions
        self.medications = medications
    }
    
    required init?(coder: NSCoder) {
        self.dob = (coder.decodeObjectForKey("dob") as? NSDate) ?? NSDate()
        self.height = (coder.decodeObjectForKey("height") as? String) ?? ""
        self.weight = (coder.decodeObjectForKey("weight") as? String) ?? ""
        self.allergies = (coder.decodeObjectForKey("allergies") as? String) ?? ""
        self.previousMedicalConditions = (coder.decodeObjectForKey("previousMedicalConditions") as? String) ?? ""
        self.medications = (coder.decodeObjectForKey("medications") as? String) ?? ""
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(dob, forKey: "dob")
        coder.encodeObject(height, forKey: "height")
        coder.encodeObject(weight, forKey: "weight")
        coder.encodeObject(allergies, forKey: "allergies")
        coder.encodeObject(previousMedicalConditions, forKey: "previousMedicalConditions")
        coder.encodeObject(medications, forKey: "medications")
    }
    
}