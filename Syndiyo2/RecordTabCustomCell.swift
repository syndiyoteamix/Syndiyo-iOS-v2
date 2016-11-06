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
    
    @IBOutlet weak var checkMarkImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
