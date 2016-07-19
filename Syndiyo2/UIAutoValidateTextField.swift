//
//  UIValidatingTextField.swift
//  Syndiyo2
//
//  Created by Ilham Nurjadin on 7/19/16.
//  Copyright © 2016 Alan-Yu. All rights reserved.
//

import UIKit

class UIAutoValidateTextField: UITextField {
// updates text when editing

    let correctImage = UIImage(named: "checkmark")
    let imageView = UIImageView()
    
    var isValid: Bool {
        if let text = self.text {
            // if text is not nil, check if text is empty
            // if text is empty, return false
            // if text is not empty, return true
            return !text.isEmpty
        }
        else {
            // if text is nil, return false
            return false
        }
    }
    
    // Always need to call superclass' initializer
    override init(frame: CGRect) {
        super.init(frame: frame)        // set the frame equal to whatever frame we pass to it
        
        // Sets up a way for the textfield to recognize different events
        self.addTarget(self, action: #selector(textUpdated), forControlEvents: .EditingChanged)
        // self -- what we connect the target to (tells self to start listening for this event)
        // If the event occurs, we call the action on self
        // forControlEvent -- the state of the textfield
        // Selector is called when in the middle of editing
        
        self.addSubview(imageView)
        
        // Center image in imageView
        imageView.contentMode = .ScaleToFill
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.addTarget(self, action: #selector(textUpdated), forControlEvents: .EditingChanged)
        
        self.addSubview(imageView)
        
        // Center image in imageView
        imageView.contentMode = .ScaleToFill
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Origin is at the top left corner
        let imageViewHeight = self.frame.height / 2
        let imageViewWidth = imageViewHeight
        let imageViewY: CGFloat = imageViewHeight / 4
        let imageViewX: CGFloat = self.frame.width - imageViewWidth
        imageView.frame = CGRect(x: imageViewX, y: imageViewY, width: imageViewWidth, height: imageViewHeight)
    }
    
    func textUpdated() {
        // handler for when the text changes
        
        if isValid {
            self.imageView.image = correctImage
        }
        
    }

}
