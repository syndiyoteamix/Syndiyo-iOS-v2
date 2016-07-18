//
//  MedicalRecord.swift
//  Syndiyo
//
//  Created by Ilham Nurjadin on 7/18/16.
//  Copyright © 2016 Alan-Yu. All rights reserved.
//

import Foundation
import UIKit

class MedicalRecord {
    
    var name: String
    var description: String
    var date: NSDate
    var image: UIImage
    
//    init() {
//        self.name = ""
//        self.description = ""
//        self.date = NSDate()
//        self.image = UIImage()
//    }
    
    
    init(name: String, description: String?, date:NSDate, image: UIImage) {
        
        
        self.name = name
        self.description = description ?? ""
        self.image = image
        self.date = date
        
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
    
}