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
    var date: NSDate
    var image: UIImage
    //should make enum eventually
    var category: String
    
//    init() {
//        self.name = ""
//        self.description = ""
//        self.date = NSDate()
//        self.image = UIImage()
//    }
    
    
    init(name: String, notes: String?, date:NSDate?, image: UIImage??, category: String) {
        
        self.name = name
        self.notes = notes ?? ""
        self.image = (image ?? UIImage(named: "GoodCamera"))!
        self.date = date ?? NSDate()
        self.category = category
        
//        // Getting date
//        let myDate = NSDate()
//        let calendar = NSCalendar.currentCalendar()
//        let components = calendar.components([.Day , .Month , .Year], fromDate: myDate)
//        self.date = myDate
        
    }
    
    func getDateString() -> String {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .LongStyle
        dateFormatter.timeStyle = .ShortStyle
        
        return dateFormatter.stringFromDate(date)
    }
    
    required init?(coder: NSCoder) {
        self.name = (coder.decodeObjectForKey("name") as? String) ?? ""
        self.notes = (coder.decodeObjectForKey("notes") as? String) ?? ""
        self.date = (coder.decodeObjectForKey("date") as? NSDate) ?? NSDate()
        self.image = (coder.decodeObjectForKey("image") as? UIImage) ?? UIImage()
        self.category = (coder.decodeObjectForKey("category") as? String) ?? ""
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(name, forKey: "name")
        coder.encodeObject(notes, forKey: "notes")
        coder.encodeObject(date, forKey: "date")
        coder.encodeObject(image, forKey: "image")
        coder.encodeObject(category, forKey: "category")
    }
    
}