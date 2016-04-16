//
//  HistoryOrdersTableViewCell.swift
//  FeedMeIOS
//
//  Created by Jun Chen on 3/04/2016.
//  Copyright © 2016 FeedMe. All rights reserved.
//

import UIKit

class HistoryOrdersTableViewCell: UITableViewCell {

    @IBOutlet weak var OrderStateLabel: UILabel!
    @IBOutlet weak var RestaurantLabel: UILabel!
    @IBOutlet weak var GrandTotalLabel: UILabel!
    @IBOutlet weak var DeliveryFeeLabel: UILabel!
    @IBOutlet weak var OrderDateLabel: UILabel!
    @IBOutlet weak var TrackingOrderButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
