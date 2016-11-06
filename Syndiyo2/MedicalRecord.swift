//
//  MedicalRecord.swift
//  Syndiyo
//
//  Created by Ilham Nurjadin on 7/18/16.
//  Copyright © 2016 Alan-Yu. All rights reserved.
//

import Foundation
import UIKit

class MedicalRecord : NSObject, NSCoding {
    
    var name: String
    var notes: String
    var date: Date
    var image: UIImage
    //should make enum eventually
    var category: String
    
//    init() {
//        self.name = ""
//        self.description = ""
//        self.date = NSDate()
//        self.image = UIImage()
//    }
    
    
    init(name: String, notes: String?, date:Date?, image: UIImage??, category: String) {
        
        self.name = name
        self.notes = notes ?? ""
        self.image = (image ?? UIImage(named: "GoodCamera"))!
        self.date = date ?? Date()
        self.category = category
        
//        // Getting date
//        let myDate = NSDate()
//        let calendar = NSCalendar.currentCalendar()
//        let components = calendar.components([.Day , .Month , .Year], fromDate: myDate)
//        self.date = myDate
        
    }
    
    func getDateString() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        
        return dateFormatter.string(from: date)
    }
    
    required init?(coder: NSCoder) {
        self.name = (coder.decodeObject(forKey: "name") as? String) ?? ""
        self.notes = (coder.decodeObject(forKey: "notes") as? String) ?? ""
        self.date = (coder.decodeObject(forKey: "date") as? Date) ?? Date()
        self.image = (coder.decodeObject(forKey: "image") as? UIImage) ?? UIImage()
        self.category = (coder.decodeObject(forKey: "category") as? String) ?? ""
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(notes, forKey: "notes")
        coder.encode(date, forKey: "date")
        coder.encode(image, forKey: "image")
        coder.encode(category, forKey: "category")
    }
    
}
