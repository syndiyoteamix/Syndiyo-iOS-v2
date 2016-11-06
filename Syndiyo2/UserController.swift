//
//  UserController.swift
//  Syndiyo
//
//  Created by Ilham Nurjadin on 7/18/16.
//  Copyright © 2016 Alan-Yu. All rights reserved.
//

import Foundation
import UIKit



enum State {
    
    case sendingDoc
    
    case requestingDoc
    
    case view
    
}


class UserController {
    
    let manager = FileManager.default
    
    static let sharedInstance = UserController()
    
    
    
    
    var currentUser: User?
    var currentRecord: MedicalRecord?
    var currentDoctor: Doctor?
    var state:State = .view
    
    var fakeDoctors:[Doctor] = [Doctor(name: "BS1", speciality: "", address: "", email: "BS1@gmail.com", fax: "", phone: "", profilePic: nil), Doctor(name: "BS2", speciality: "", address: "", email: "", fax: "", phone: "", profilePic: nil)]
    
    
    
    
    var fakeMedicalRecords:[MedicalRecord] = [MedicalRecord(name: "MR1", notes: "", date: Date(), image: UIImage(named: "CameraIcon")!,category:"Medical"),MedicalRecord(name: "Apple", notes: "", date: Date(), image: UIImage(named:"apple")!,category:"Medical"),MedicalRecord(name: "Bird", notes: "", date: Date(), image: UIImage(named: "angryBird")!,category:"Medical")]
   
    var users: [User] = [User]()
    
    var recordsToSend:[MedicalRecord]?

    
    func updateUsersArray() {
        for user in users{
            if user.ID == currentUser!.ID {
                let index:Int = users.index(of: user)!
                users.remove(at: index)
                users.insert(currentUser!, at: index)
                saveUsersArray()
            }
        }
    }
    
    
    
    func registerUser(_ onCompletion: (String?) -> Void) {
        if currentUser != nil {
            users.append(currentUser!)
            onCompletion(nil)
            saveUsersArray()
            print("yo")
        }
        // if CurrentUser is nil
        else { onCompletion("Could not register user") }
    }
    
    
    func loginUser(_ email: String, password: String, onCompletion: (User?, String?) -> Void) {
        if users.isEmpty {
            onCompletion(nil, "Email or password is incorrect")
        }
        for person in users {
            if person.email == email && person.password == password {
                onCompletion(person, nil)
            }
        }
        onCompletion(nil, "Email or password is incorrect")
    }
    
    
    func checkUsernameAvailability(_ email: String) -> Bool {
        for person in users {
            if person.email == email { return false }
        }
        return true
    }
   
    
    func saveUsersArray(){
        let documents = manager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documents.appendingPathComponent("users.txt")
        
        NSKeyedArchiver.archiveRootObject(users, toFile: fileURL.path)
    }
    
    
    func addMedicalRecord(_ record:MedicalRecord){
        currentUser?.medicalRecords?.append(record)
     //   fakeMedicalRecords.append(record)
    }
    
    func userMedicalRecords() -> [MedicalRecord]{
        return currentUser!.medicalRecords!
    }
    
    
    func updateUserInfo() {
        
    }
    
    func updateMedicalInformation(_ medicalInfo: MedicalInformation) {
        
    }
    
    func addDoctors(_ doctors: [Doctor]) {
        currentUser?.doctorsArray!.append(contentsOf: doctors)
    }
    
    func updateDoctorsArray() {
        for doct in currentUser!.doctorsArray! {
            if doct.UUID == currentDoctor!.UUID {
                let index = currentUser!.doctorsArray!.index(of: doct)!
                currentUser?.doctorsArray!.remove(at: index)
                currentUser?.doctorsArray!.insert(doct, at: index)
            }
        }
    }
    
    func deleteDoctor() {
        
    }
    
}
