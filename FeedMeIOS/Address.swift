//
//  Address.swift
//  FeedMeIOS
//
//  Created by Jun Chen on 28/03/2016.
//  Copyright © 2016 FeedMe. All rights reserved.
//

import Foundation

class Address {
    var userName: String?
    var addressLine1: String?
    var addressLine2: String?
    var suburb: String! = "Canberra"
    var state: String! = "ACT"
    var postcode: String?
    var phone: String?
    var selected: Bool! = false
    
    
    init(userName: String?, addressLine1: String?, addressLine2: String?, postcode: String?, phone: String?, suburb: String?, state: String?, selected: Bool?) {
        self.userName = userName
        self.addressLine1 = addressLine1
        self.addressLine2 = addressLine2
        self.postcode = postcode
        self.phone = phone
        self.suburb = suburb
        self.state = state
    }
    
    func toSimpleAddressString() -> String {
        return addressLine1! + " " + addressLine2! + ", " + suburb + " " + state + " " + postcode!
    }
    
    func toFormattedString() -> String {
        var formattedAddressString = userName!
        formattedAddressString += ("\n" + addressLine1!)
        formattedAddressString += ("\n" + addressLine2! + ", " + suburb + ", " + state + " " + postcode!)
        formattedAddressString += ("\n" + phone!)
        
        return formattedAddressString
    }
    
    func isSelected() -> Bool {
        return self.selected
    }
    
    func setAsSelected() {
        self.selected = true
    }
    
    func setAsDeselected() {
        self.selected = false
    }
    
}
