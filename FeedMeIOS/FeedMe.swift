//
//  FeedMe.swift
//  FeedMeIOS
//
//  Created by Jun Chen on 19/03/2016.
//  Copyright © 2016 FeedMe. All rights reserved.
//

import UIKit

struct FeedMe {
    
    struct Path {
        static let TEXT_HOST = "http://ec2-52-27-149-51.us-west-2.compute.amazonaws.com:8080/"
        static let PICTURE_HOST = "http://ec2-52-27-149-51.us-west-2.compute.amazonaws.com:8080/"
    }
    
    struct Variable {
        static var userID: Int?
        static var restaurantID: Int?
        static var restaurantName: String?
        static var dishID: Int?
        static var images: [String: UIImage]?
        static var order: Order?
        static var dishes: [Int: Dish]!
        static var selectedDeliveryAddress: Address!
        static var userInLoginState: Bool = false
    }
    
    static var user: User?
    static var machineCode: String = UIDevice.currentDevice().identifierForVendor!.UUIDString
    
    static var transColor4 = UIColor(red: 255/225, green: 255/255, blue: 255/255, alpha: 0.4)
    static var transColor7 = UIColor(red: 255/225, green: 255/255, blue: 255/255, alpha: 0.7)
    static var mainRed = UIColor(red: 208/225, green: 62/255, blue: 34/255, alpha: 1.0)
    static var white = UIColor(red: 255/225, green: 255/255, blue: 255/255, alpha: 1.0);
}

enum DishType: String {
    case Entree = "Entree"
    case Soup = "Soup"
    case Dessert = "Dessert"
    case Drinks = "Drinks"
    case Others = "Others"
}
