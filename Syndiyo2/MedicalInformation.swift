//
//  MedicalInformation.swift
//  syndiyoInitialCode
//
//  Created by Ilham Nurjadin on 7/18/16.
//  Copyright © 2016 IlhamNurjadin. All rights reserved.
//

import Foundation

class MedicalInformation: NSObject, NSCoding {
    
    var dob: Date?
    var height: String?
    var weight: String?
    var allergies: String?
    var previousMedicalConditions: String?
    var medications: String?

    init(dob: Date?, height: String?, weight: String?, allergies: String?, previousMedicalConditions: String?, medications: String?) {
        self.dob = dob ?? nil
        self.height = height ?? ""
        self.weight = weight ?? ""
        self.allergies = allergies ?? ""
        self.previousMedicalConditions = previousMedicalConditions ?? ""
        self.medications = medications ?? ""
    }
    
    required init?(coder: NSCoder) {
        self.dob = (coder.decodeObject(forKey: "dob") as? Date) ?? nil
        self.height = (coder.decodeObject(forKey: "height") as? String) ?? ""
        self.weight = (coder.decodeObject(forKey: "weight") as? String) ?? ""
        self.allergies = (coder.decodeObject(forKey: "allergies") as? String) ?? ""
        self.previousMedicalConditions = (coder.decodeObject(forKey: "previousMedicalConditions") as? String) ?? ""
        self.medications = (coder.decodeObject(forKey: "medications") as? String) ?? ""
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(dob, forKey: "dob")
        coder.encode(height, forKey: "height")
        coder.encode(weight, forKey: "weight")
        coder.encode(allergies, forKey: "allergies")
        coder.encode(previousMedicalConditions, forKey: "previousMedicalConditions")
        coder.encode(medications, forKey: "medications")
    }
    
}
