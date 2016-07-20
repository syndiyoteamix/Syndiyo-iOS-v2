//
//  Doctor.swift
//  syndiyoInitialCode
//
//  Created by Ilham Nurjadin on 7/18/16.
//  Copyright © 2016 IlhamNurjadin. All rights reserved.
//

import Foundation

class Doctor: NSObject, NSCoding {
    
    var name: String
    var speciality: String?
    var address: String?
    var email: String
    var fax: String?
    var phone: String?
    
//    init() {
//        self.name = ""
//        self.email = ""
//    }
    
    init(name: String, speciality: String, address: String, email: String, fax: String, phone: String) {
        self.name = name
        self.speciality = speciality
        self.address = address
        self.email = email
        self.fax = fax
        self.phone = phone
    }
    
    required init?(coder: NSCoder) {
        self.name = (coder.decodeObjectForKey("name") as? String) ?? ""
        self.speciality = (coder.decodeObjectForKey("speciality") as? String) ?? ""
        self.address = (coder.decodeObjectForKey("address") as? String) ?? ""
        self.email = (coder.decodeObjectForKey("email") as? String) ?? ""
        self.fax = (coder.decodeObjectForKey("fax") as? String) ?? ""
        self.phone = (coder.decodeObjectForKey("phone") as? String) ?? ""
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(name, forKey: "name")
        coder.encodeObject(speciality, forKey: "speciality")
        coder.encodeObject(address, forKey: "address")
        coder.encodeObject(email, forKey: "email")
        coder.encodeObject(fax, forKey: "fax")
        coder.encodeObject(phone, forKey: "phone")
    }
    
}
