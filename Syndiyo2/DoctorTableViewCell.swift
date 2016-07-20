//
//  DoctorTableViewCell.swift
//  Syndiyo2
//
//  Created by Ilham Nurjadin on 7/20/16.
//  Copyright © 2016 Alan-Yu. All rights reserved.
//

import UIKit

class DoctorTableViewCell: UITableViewCell {

    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var nameTextField: UILabel!
    @IBOutlet weak var emailTextField: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        profilePictureImageView.layer.cornerRadius = 15
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
