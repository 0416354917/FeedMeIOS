//
//  TrackingOrderTableViewCell.swift
//  FeedMeIOS
//
//  Created by Jun Chen on 15/04/2016.
//  Copyright © 2016 FeedMe. All rights reserved.
//

import UIKit

class OrderDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var dishNameLabel: UILabel!
    @IBOutlet weak var dishUnitPriceLabel: UILabel!
    @IBOutlet weak var dishQtyLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
