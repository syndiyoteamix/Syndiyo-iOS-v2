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
    var doctorsArray: [Doctor]? = [Doctor(name: "Rafi", speciality: "eats a lot of chocolate", address: "22 cloverfield lane", email: "Rafi@ixperience.co.za", fax: "", phone: "9098768356", profilePic: nil), Doctor(name: "Alej", speciality: "Athletic Injuries", address: "1600 Pennsylvania Ave", email: "Alejandro@ixperience.co.za", fax: "", phone: "", profilePic: nil)]
    var medicalInfo: MedicalInformation?
    var medicalRecords: [MedicalRecord]? = [MedicalRecord(name: "CT SCAN Lumbar", notes: "Inflamation Found, send for follow up in 3 weeks", date: nil, image: UIImage(named: "record1"), category: ""), MedicalRecord(name: "EKG", notes: "Check for heart imbalance", date: Date(), image: UIImage(named: "record2"), category: ""), MedicalRecord(name: "Sacrum MRI Scan", notes: "Everything checked out fine", date: Date(), image: UIImage(named: "record3"), category: "")]
        
        
  

    var frontInsuranceCard: UIImage?
    var backInsuranceCard: UIImage?
    var ID: UUID = UUID()
    
   
    
    
    var fakeDoctor:[Doctor] = [Doctor(name: "James Collin", speciality: "eats a lot of chocolate", address: "22 cloverfield lane", email: "Collin@gmail.com", fax: "", phone: "9098768356", profilePic: nil), Doctor(name: "Sophia Deng", speciality: "Athletic Injuries", address: "1600 Pennsylvania Ave", email: "Sophia@gmail.com", fax: "", phone: "", profilePic: nil)]
    
    init(firstName: String?, lastName: String?, email: String?, password: String?, ssn: Int?, doctorsArray: [Doctor]?, medicalInfo: MedicalInformation?) {
        self.firstName = firstName ?? "No name"
        self.lastName = lastName ?? "no last name"
        self.email = email ?? ""
        self.password = password ?? ""
        self.ssn = ssn ?? 0
        self.doctorsArray = doctorsArray ?? [Doctor(name: "Rafi", speciality: "eats a lot of chocolate", address: "22 cloverfield lane", email: "Rafi@ixperience.co.za", fax: "", phone: "9098768356", profilePic: nil), Doctor(name: "Alej", speciality: "Athletic Injuries", address: "1600 Pennsylvania Ave", email: "alejandro@ixperience.co.za", fax: "", phone: "", profilePic: nil)]
        self.medicalInfo = medicalInfo ?? MedicalInformation(dob: nil, height: nil, weight: nil, allergies: nil, previousMedicalConditions: nil, medications: nil)
    }
    
    required init?(coder: NSCoder) {
        self.firstName = (coder.decodeObject(forKey: "firstName") as? String) ?? ""
        self.lastName = (coder.decodeObject(forKey: "lastName") as? String) ?? ""
        self.email = (coder.decodeObject(forKey: "email") as? String) ?? ""
        self.password = (coder.decodeObject(forKey: "password") as? String) ?? ""
        self.ssn = (coder.decodeObject(forKey: "ssn") as? Int) ?? 0
        self.doctorsArray = (coder.decodeObject(forKey: "doctorsArray") as? [Doctor]) ?? []
        self.medicalInfo = (coder.decodeObject(forKey: "medicalInfo") as? MedicalInformation) ?? MedicalInformation(dob: nil, height: nil, weight: nil, allergies: nil, previousMedicalConditions: nil, medications: nil)
        self.medicalRecords = (coder.decodeObject(forKey: "medicalRecords") as? [MedicalRecord]) ?? []
        self.frontInsuranceCard = (coder.decodeObject(forKey: "frontInsuranceCard") as? UIImage) ?? UIImage()
        self.backInsuranceCard = (coder.decodeObject(forKey: "backInsuranceCard") as? UIImage) ?? UIImage()
        self.ID = (coder.decodeObject(forKey: "ID") as? UUID) ?? UUID()
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(firstName, forKey: "firstName")
        coder.encode(lastName, forKey: "lastName")
        coder.encode(email, forKey: "email")
        coder.encode(password, forKey: "password")
        coder.encode(ssn, forKey: "ssn")
        coder.encode(doctorsArray, forKey: "doctorsArray")
        coder.encode(medicalInfo, forKey: "medicalInfo")
        coder.encode(medicalRecords, forKey: "medicalRecords")
        coder.encode(frontInsuranceCard, forKey: "frontInsuranceCard")
        coder.encode(backInsuranceCard, forKey: "backInsuranceCard")
        coder.encode(ID, forKey: "ID")
    }
    
}
