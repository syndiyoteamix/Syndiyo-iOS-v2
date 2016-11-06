//
//  Doctor.swift
//  syndiyoInitialCode
//
//  Created by Ilham Nurjadin on 7/18/16.
//  Copyright © 2016 IlhamNurjadin. All rights reserved.
//

import Foundation
import UIKit

class Doctor: NSObject, NSCoding {
    
    var name: String
    var speciality: String?
    var address: String?
    var email: String
    var fax: String?
    var phone: String?
    var profilePic: UIImage?
    var UUID:Foundation.UUID = Foundation.UUID()
    
//    init() {
//        self.name = ""
//        self.email = ""
//    }
    
    init(name: String?, speciality: String?, address: String?, email: String?, fax: String?, phone: String?, profilePic:UIImage?) {
        self.name = name ?? "no name"
        self.speciality = speciality ?? "no speciality"
        self.address = address ?? "has no house"
        self.email = email ?? "can't connect to wifi "
        self.fax = fax ?? "no one uses fax anymore"
        self.phone = phone ?? "dropped iphone to many times " 
        self.profilePic = profilePic ?? UIImage(named: "smallDoctor")
    }
    
    required init?(coder: NSCoder) {
        self.name = (coder.decodeObject(forKey: "name") as? String) ?? ""
        self.speciality = (coder.decodeObject(forKey: "speciality") as? String) ?? ""
        self.address = (coder.decodeObject(forKey: "address") as? String) ?? ""
        self.email = (coder.decodeObject(forKey: "email") as? String) ?? ""
        self.fax = (coder.decodeObject(forKey: "fax") as? String) ?? ""
        self.phone = (coder.decodeObject(forKey: "phone") as? String) ?? ""
        self.profilePic = (coder.decodeObject(forKey: "profilePic") as? UIImage) ?? UIImage(named:"smallDoctor")
        self.UUID = (coder.decodeObject(forKey: "UUID") as? Foundation.UUID) ?? Foundation.UUID()
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(speciality, forKey: "speciality")
        coder.encode(address, forKey: "address")
        coder.encode(email, forKey: "email")
        coder.encode(fax, forKey: "fax")
        coder.encode(phone, forKey: "phone")
        coder.encode(profilePic, forKey: "profilePic")
        coder.encode(UUID, forKey: "UUID")
    }
    
}
