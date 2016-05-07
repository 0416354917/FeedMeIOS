//
//  OrderDish.swift
//  FeedMeIOS
//
//  Created by Jun Chen on 7/05/2016.
//  Copyright © 2016 FeedMe. All rights reserved.
//

import Foundation

class OrderDish: EVObject {
    
    var id: Int?
    var orderId: Int?
    var dishId: Int?
    var amount: Int?
    var price: Int?
    
    
    required init() {
        
    }
    
    init(dishId: Int?, amount: Int?, price: Int?) {
        self.dishId = dishId
        self.amount = amount
        self.price = price
    }
    
    func getId() -> Int? {
        return self.id
    }
    
    func setId(id: Int?) {
        self.id = id
    }
    
    func getOrderId() -> Int? {
        return self.orderId
    }
    
    func setOrderId(orderId: Int?) {
        self.orderId = orderId
    }
    
    func getDishId() -> Int? {
        return self.dishId
    }
    
    func setDishId(dishId: Int?) {
        self.dishId = dishId
    }
    
    func getAmount() -> Int? {
        return self.amount
    }
    
    func setAmount(amount: Int?) {
        self.amount = amount
    }
    
    func getPrice() -> Int? {
        return self.price
    }
    
    func setPrice(price: Int?) {
        self.price = price
    }
    
}
