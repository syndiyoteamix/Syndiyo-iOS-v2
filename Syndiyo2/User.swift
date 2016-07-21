//
//  User.swift
//  syndiyoInitialCode
//
//  Created by Ilham Nurjadin on 7/18/16.
//  Copyright © 2016 IlhamNurjadin. All rights reserved.
//

import Foundation
import UIKit

class User : NSObject, NSCoding {
    
    var firstName: String
    var lastName: String
    var email: String
    var password: String
    var ssn: Int
    var doctorsArray: [Doctor]?
    var medicalInfo: MedicalInformation?
    var medicalRecords: [MedicalRecord]?
    var frontInsuranceCard: UIImage?
    var backInsuranceCard: UIImage?
    var ID: NSUUID = NSUUID()
    
//    init() {
//        self.firstName = ""
//        self.lastName = ""
//        self.email = ""
//        self.username = ""
//        self.password = ""
//        self.ssn = 0
//        self.doctorsArray = [Doctor]()
//        self.medicalInfo = MedicalInformation()
//    }
    
    init(firstName: String?, lastName: String?, email: String?, password: String?, ssn: Int?, doctorsArray: [Doctor]?, medicalInfo: MedicalInformation?) {
        self.firstName = firstName ?? "No name"
        self.lastName = lastName ?? "no last name"
        self.email = email ?? ""
        self.password = password ?? ""
        self.ssn = ssn ?? 0
        self.doctorsArray = doctorsArray ?? []
        self.medicalInfo = medicalInfo ?? MedicalInformation(dob: nil, height: nil, weight: nil, allergies: nil, previousMedicalConditions: nil, medications: nil)
    }
    
    required init?(coder: NSCoder) {
        self.firstName = (coder.decodeObjectForKey("firstName") as? String) ?? ""
        self.lastName = (coder.decodeObjectForKey("lastName") as? String) ?? ""
        self.email = (coder.decodeObjectForKey("email") as? String) ?? ""
        self.password = (coder.decodeObjectForKey("password") as? String) ?? ""
        self.ssn = (coder.decodeObjectForKey("ssn") as? Int) ?? 0
        self.doctorsArray = (coder.decodeObjectForKey("doctorsArray") as? [Doctor]) ?? []
        self.medicalInfo = (coder.decodeObjectForKey("medicalInfo") as? MedicalInformation) ?? MedicalInformation(dob: nil, height: nil, weight: nil, allergies: nil, previousMedicalConditions: nil, medications: nil)
        self.medicalRecords = (coder.decodeObjectForKey("medicalRecords") as? [MedicalRecord]) ?? []
        self.frontInsuranceCard = (coder.decodeObjectForKey("frontInsuranceCard") as? UIImage) ?? UIImage()
        self.backInsuranceCard = (coder.decodeObjectForKey("backInsuranceCard") as? UIImage) ?? UIImage()
        self.ID = (coder.decodeObjectForKey("ID") as? NSUUID) ?? NSUUID()
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(firstName, forKey: "firstName")
        coder.encodeObject(lastName, forKey: "lastName")
        coder.encodeObject(email, forKey: "email")
        coder.encodeObject(password, forKey: "password")
        coder.encodeObject(ssn, forKey: "ssn")
        coder.encodeObject(doctorsArray, forKey: "doctorsArray")
        coder.encodeObject(medicalInfo, forKey: "medicalInfo")
        coder.encodeObject(medicalRecords, forKey: "medicalRecords")
        coder.encodeObject(frontInsuranceCard, forKey: "frontInsuranceCard")
        coder.encodeObject(backInsuranceCard, forKey: "backInsuranceCard")
        coder.encodeObject(ID, forKey: "ID")
    }
    
}
