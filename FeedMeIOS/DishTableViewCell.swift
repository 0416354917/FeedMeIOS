//
//  DishTableViewCell.swift
//  FeedMeIOS
//
//  Created by Jun Chen on 19/03/2016.
//  Copyright © 2016 FeedMe. All rights reserved.
//

import UIKit

class DishTableViewCell: UITableViewCell {
    
    // MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var addToShoppingCart: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func addToShoppingCart(sender: UIButton) {
        FeedMe.Variable.order!.addDish(FeedMe.Variable.dishes![addToShoppingCart.tag]!)
        print("Add to cart: \(FeedMe.Variable.dishes[addToShoppingCart.tag]!.name!)")
        print("Total price is now: \(FeedMe.Variable.order!.totalPrice)")
        print("Total count is now: \(FeedMe.Variable.order!.totalItems)")
    }
    
}
