//
//  UIValidationTextField.swift
//  Syndiyo2
//
//  Created by Ilham Nurjadin on 7/19/16.
//  Copyright © 2016 Alan-Yu. All rights reserved.
//

import UIKit

class UIValidationTextField: UITextField {
// does update icon automatically
    
    let correctImage = UIImage(named: "checkmark")
    let imageView = UIImageView()
    
    var isValid: Bool = false {
        didSet {
            if isValid == false {}
            else {
                self.imageView.image = correctImage
            }
        }
    }
    
    // Always need to call superclass' initializer
    override init(frame: CGRect) {
        super.init(frame: frame)        // set the frame equal to whatever frame we pass to it
        
        self.addSubview(imageView)
        imageView.contentMode = .ScaleToFill    // Center image in imageView
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.addSubview(imageView)
        imageView.contentMode = .ScaleToFill    // Center image in imageView
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

}
