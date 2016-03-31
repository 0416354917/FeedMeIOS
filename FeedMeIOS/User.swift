//
//  User.swift
//  FeedMeIOS
//
//  Created by Jun Chen on 28/03/2016.
//  Copyright © 2016 FeedMe. All rights reserved.
//

import Foundation

class User {
    var userID: String?
    var userName: String?
    var phone: String?
    var email: String?
    
    var defaultDeliveryAddress: Address? = Address(userName: "CSIT", addressLine1: "108 N Rd", addressLine2: "Acton", postcode: "2601", phone: "(02) 6125 5111", suburb: "Canberra", state: "ACT", selected: true)
    var deliveryAddresses: [Address]?
    
    init() {
        
    }
    
    init(userID: String?, userName: String?, phone: String?, email: String?, defaultDeliveryAddress: Address?, deliveryAddresses: [Address]?) {
        self.userID = userID
        self.userName = userName
        self.phone = phone
        self.email = email
        self.defaultDeliveryAddress = defaultDeliveryAddress
        self.deliveryAddresses = deliveryAddresses
    }
    
}