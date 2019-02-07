//
//  TableViewCell.swift
//  pickImage
//
//  Created by Bayan Zomarah on 12/7/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    
 @IBOutlet weak var memeLabel: UILabel!
    @IBOutlet weak var Tcell:UIImageView!{
        didSet {
            self.contentMode = .scaleAspectFit
        }
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
