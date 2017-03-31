//
//  ItemCell.swift
//  Homepwner3
//
//  Created by LARRY COMBS on 1/19/17.
//  Copyright © 2017 LARRY COMBS. All rights reserved.
//

import UIKit

class ItemCell : UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var serialNumberLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!
    



  override func awakeFromNib() {
    super.awakeFromNib()
    
    nameLabel.adjustsFontForContentSizeCategory = true
    serialNumberLabel.adjustsFontForContentSizeCategory = true
    valueLabel.adjustsFontForContentSizeCategory = true

    }

}
