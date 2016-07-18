//
//  Doctor.swift
//  syndiyoInitialCode
//
//  Created by Ilham Nurjadin on 7/18/16.
//  Copyright © 2016 IlhamNurjadin. All rights reserved.
//

import Foundation

class Doctor {
    
    var name: String
    var speciality: String
    var address: String
    var contactInformation: String
    
    init() {
        self.name = ""
        self.speciality = ""
        self.address = ""
        self.contactInformation = ""
    }
    
    init(name: String, speciality: String, address: String, contactInformation: String) {
        self.name = name
        self.speciality = speciality
        self.address = address
        self.contactInformation = contactInformation
    }
    
}
