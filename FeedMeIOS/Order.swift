//
//  Order.swift
//  FeedMeIOS
//
//  Created by Jun Chen on 25/03/2016.
//  Copyright © 2016 FeedMe. All rights reserved.
//

import Foundation

class Order {
    
    // MARK: Properties
    var userID: String?
    var restaurantID: Int?
    var orderTime: String?
    var deliveryAddress: String?
    var phoneNumber: String?
    // information for all dishes in the shopping cart:
    // list of all dishes:
    var id2dish: [Int: Dish]
    // count of every dish: Dish ID -> Dish Count:
    var id2count: [Int: Int]
    
    // total number of items:
    var totalItems: Int = 0
    
    // total number of prices:
    var totalPrice: Double = 0

    
    // MARK: Initialization
    init(userID: String?, restaurantID: Int) {
        self.userID = userID
        self.restaurantID = restaurantID
        self.id2dish = [Int: Dish]()
        self.id2count = [Int: Int]()
    }

    
    // MARK: Methods
    // Set the timestamp when order is conformed.
    func setTime() {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        self.orderTime = dateFormatter.stringFromDate(NSDate())
    }
    
    // Set the delivery address.
    func setDeliverAddress(deliveryAddress: String) {
        self.deliveryAddress = deliveryAddress
    }
    
    // Set the contact phone number.
    func setPhoneNumber(phoneNumber: String) {
        self.phoneNumber = phoneNumber
    }
    
    // Change and set items count.
    func changeItemsCount(increase: Bool, qty: Int) {
        self.totalItems = increase ? self.totalItems + qty : self.totalItems - qty
    }
    
    // Change and set total price.
    func changeTotalPrice(increase: Bool, amount: Double) {
        self.totalPrice = increase ? self.totalPrice + amount : self.totalPrice - amount
    }
    
    // Add dish to the order.
    func addDish(newDish: Dish, qty: Int = 1) {
        let dishID = newDish.ID
        if id2dish[dishID] != nil {
            id2count[dishID] = id2count[dishID]! + qty
        } else {
            id2dish[dishID] = newDish
            id2count[dishID] = qty
        }
        
        totalItems += qty
        totalPrice += Double(newDish.price!) * Double(qty)
    }
    
    // Remove dish from the order.
    func removeDish(dishID: Int, qty: Int = 1) {
        totalItems -= qty
        totalPrice -= Double(id2dish[dishID]!.price!) * Double(qty)
        
        id2count[dishID] = id2count[dishID]! - qty
        if id2count[dishID] == 0 {
            id2dish.removeValueForKey(dishID)
            id2count.removeValueForKey(dishID)
        }
    }
    
    // Check if the order is empty.
    func isEmptyOrder() -> Bool {
        return self.totalPrice == 0
    }
    
    // Get the number of dishes group by dish.
    func count() -> Int {
        return self.id2count.count
    }
    
    // Get the list of all dishes.
    func dishesList() -> [Dish] {
        var dishesList = [Dish]()
        for (_, dish) in id2dish {
            dishesList += [dish]
        }
        return dishesList
    }
    
    // Get the Qty of a dish: Dish.
    func dishQty(dish: Dish) -> Int {
        return self.id2count[dish.ID]!
    }

}