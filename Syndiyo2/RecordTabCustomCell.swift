//
//  RecordTabCustomCell.swift
//  Syndiyo2
//
//  Created by Alan Yu on 7/19/16.
//  Copyright © 2016 Alan-Yu. All rights reserved.
//

import UIKit

class RecordTabCustomCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var documentImage: UIImageView!
    
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        containerView.layer.cornerRadius = 5
        containerView.layer.masksToBounds = true
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
