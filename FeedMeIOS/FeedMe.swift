//
//  FeedMe.swift
//  FeedMeIOS
//
//  Created by Jun Chen on 19/03/2016.
//  Copyright © 2016 FeedMe. All rights reserved.
//

import Foundation

struct FeedMe {
    
    struct Path {
        static let TEXT_HOST = "http://ec2-52-27-149-51.us-west-2.compute.amazonaws.com:8080/"
        static let PICTURE_HOST = "http://ec2-52-27-149-51.us-west-2.compute.amazonaws.com:8080/"
    }
    
    struct Variable {
        static var userID: Int?
        static var restaurantID: Int?
        static var dishID: Int?
    }
    
}