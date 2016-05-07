//
//  PostOrderHeader.swift
//  FeedMeIOS
//
//  Created by Jun Chen on 7/05/2016.
//  Copyright © 2016 FeedMe. All rights reserved.
//

import Foundation


class PostOrderHeader: EVObject {
    var userId: Int?
    var restaurantId: Int?
    var addressId: Int?
    var paymentStatus: String?
    var totalPrice: Int?
    
    required init() {
        
    }
    
    init(userId: Int?, restaurantId: Int?, addressId: Int?, paymentStatus: String?, totalPrice: Int?) {
        self.userId = userId
        self.restaurantId = restaurantId
        self.addressId = addressId
        self.paymentStatus = paymentStatus
        self.totalPrice = totalPrice
    }
    
}