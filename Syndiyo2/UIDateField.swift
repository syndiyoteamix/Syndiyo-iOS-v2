//
//  UIDateField.swift
//  Syndiyo
//
//  Created by Alan Yu on 7/18/16.
//  Copyright © 2016 Alan-Yu. All rights reserved.
//

//thank you tobin

import UIKit

class UIDateField: UITextField {
    
    var datePicker = UIDatePicker()
    
    var date: Date {
        get {
            return datePicker.date
        }
        set(newDate) {
            datePicker.date = newDate
            formatDateText()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    fileprivate func setup() {
        let datePickerToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 44))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(closeDatePicker))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        datePickerToolbar.setItems([spacer, doneButton], animated: false)
        
        doneButton.tintColor = tintColor
        
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(formatDateText), for: .valueChanged)
        
        inputView = datePicker
        inputAccessoryView = datePickerToolbar
        
        // Hide the cursor.
        tintColor = .clear
    }
    
    func closeDatePicker() {
        formatDateText()
        resignFirstResponder()
    }
    
    func formatDateText() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, YYYY"
        
        text = formatter.string(from: datePicker.date)
    }
}
