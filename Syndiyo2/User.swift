//
//  User.swift
//  syndiyoInitialCode
//
//  Created by Ilham Nurjadin on 7/18/16.
//  Copyright © 2016 IlhamNurjadin. All rights reserved.
//

import Foundation
import UIKit

class User {
    
    var firstName: String
    var lastName: String
    var email: String
    var username: String
    var password: String
    var ssn: Int
    var doctorsArray: [Doctor]
    var medicalInfo: MedicalInformation?
    var medicalRecords: [MedicalRecord]?
    var frontInsuranceCard: UIImage?
    var backInsuranceCard: UIImage?
    
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
    
    init(firstName: String?, lastName: String?, email: String?, username: String?, password: String?, ssn: Int?, doctorsArray: [Doctor]?, medicalInfo: MedicalInformation?) {
        self.firstName = firstName ?? "No name"
        self.lastName = lastName ?? "no last name"
        self.email = email ?? ""
        self.username = username ?? ""
        self.password = password ?? ""
        self.ssn = ssn ?? 0
        self.doctorsArray = doctorsArray ?? []
        self.medicalInfo = medicalInfo ?? MedicalInformation()
    }
    
}
