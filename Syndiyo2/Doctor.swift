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
    var UUID:NSUUID = NSUUID()
    
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
        self.name = (coder.decodeObjectForKey("name") as? String) ?? ""
        self.speciality = (coder.decodeObjectForKey("speciality") as? String) ?? ""
        self.address = (coder.decodeObjectForKey("address") as? String) ?? ""
        self.email = (coder.decodeObjectForKey("email") as? String) ?? ""
        self.fax = (coder.decodeObjectForKey("fax") as? String) ?? ""
        self.phone = (coder.decodeObjectForKey("phone") as? String) ?? ""
        self.profilePic = (coder.decodeObjectForKey("profilePic") as? UIImage) ?? UIImage(named:"smallDoctor")
        self.UUID = (coder.decodeObjectForKey("UUID") as? NSUUID) ?? NSUUID()
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(name, forKey: "name")
        coder.encodeObject(speciality, forKey: "speciality")
        coder.encodeObject(address, forKey: "address")
        coder.encodeObject(email, forKey: "email")
        coder.encodeObject(fax, forKey: "fax")
        coder.encodeObject(phone, forKey: "phone")
        coder.encodeObject(profilePic, forKey: "profilePic")
        coder.encodeObject(UUID, forKey: "UUID")
    }
    
}
