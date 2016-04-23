//
//  HistoryOrders.swift
//  FeedMeIOS
//
//  Created by Jun Chen on 3/04/2016.
//  Copyright © 2016 FeedMe. All rights reserved.
//

import Foundation 

class HistoryOrders {
    
    var currentOrders: [Order]?
    var pastOrders: [Order]?
    
    init() {

    }
    
    init(currentOrders: [Order]?, pastOrders: [Order]?) {
        self.currentOrders = currentOrders
        self.pastOrders = pastOrders
    }
    
    func setCurrentOrders(currentOrders: [Order]?) {
        self.currentOrders = currentOrders
    }
    
    func getCurrentOrders() -> [Order]? {
        return self.currentOrders
    }
    
    func setPastOrders(pastOrders: [Order]?) {
        self.pastOrders = pastOrders
    }
    
    func getPastOrders() -> [Order]? {
        return self.pastOrders
    }
    
    func delete(orderType: String, index: Int) {
        if orderType == "CURRENT" {
            self.currentOrders!.removeAtIndex(index)
        } else if orderType == "HISTORY"{
            self.pastOrders!.removeAtIndex(index)
        }
    }
    
}