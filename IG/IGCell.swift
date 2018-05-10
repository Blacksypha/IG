//
//  IGCell.swift
//  IG
//
//  Created by Lorin Dashiell on 5/7/18.
//  Copyright © 2018 Cory Dashiell. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class IGCell: UITableViewCell {
    
    
    
    var instagramPost: PFObject! {
        didSet {
            self.instaImage.file = instagramPost["media"] as? PFFile
            self.caption.text = instagramPost["caption"] as! String
            self.instaImage.loadInBackground()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
