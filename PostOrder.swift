//
//  PostOrder.swift
//  FeedMeIOS
//
//  Created by Jun Chen on 7/05/2016.
//  Copyright © 2016 FeedMe. All rights reserved.
//

import Foundation

class PostOrder: EVObject {
    
    var order: PostOrderHeader?
    var dishes: [OrderDish]?
    
    required init() {
        
    }
    
    init(order: Order?) {
        super.init()
        self.dishes = [OrderDish]()
        self.createPostOrder(order)
    }
    
    func createPostOrder(order: Order?) {
        self.order = PostOrderHeader(userId: 1, restaurantId: FeedMe.Variable.restaurantID!, addressId: 1, paymentStatus: "false", totalPrice: Int(order!.totalPrice))
        
        let dishesList = order!.dishesList()
        for dish in dishesList {
            NSLog("dish id: %@", String(dish.ID))
            let orderDish = OrderDish(dishId: dish.ID, amount: order!.dishQty(dish), price: dish.price)
            dishes!.append(orderDish)
        }
    }
    
}
