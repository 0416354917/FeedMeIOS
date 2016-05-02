//
//  Util.swift
//  FeedMeIOS
//
//  Created by jevy on 9/04/2016.
//  Copyright © 2016 FeedMe. All rights reserved.
//

import Foundation

extension UITableViewController{
    func setBackground(viewController:UITableViewController){
//        let bgImage = UIImage(named:"background.png")
//        let imageView = UIImageView(frame: viewController.view.bounds)
//        imageView.image = bgImage
//        viewController.tableView.backgroundView = imageView
        viewController.tableView.backgroundColor=UIColor.whiteColor()
        
    }
    func setBar(viewTableController:UITableViewController){
        
        let nav = viewTableController.navigationController?.navigationBar
        
        nav?.tintColor = FeedMe.white
        nav?.barTintColor = FeedMe.mainRed
        nav?.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]

        viewTableController.tabBarController?.tabBar.tintColor = FeedMe.mainRed
        viewTableController.tabBarController?.tabBar.barTintColor = FeedMe.white
    }
}

extension UIViewController{
    func setViewBackground(viewController:UIViewController){
//        let bgImage = UIImage(named:"background.png")
//        let imageView = UIImageView(frame: viewController.view.bounds)
//        imageView.image = bgImage
        
//        viewController.view.backgroundColor = UIColor(patternImage: UIImage(named:"background.png")!)
    }
    func setViewBar(viewController:UIViewController){
        let nav = viewController.navigationController?.navigationBar
        nav?.tintColor = FeedMe.white
        nav?.barTintColor = FeedMe.mainRed
        nav?.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        
        viewController.tabBarController?.tabBar.tintColor = FeedMe.mainRed
        viewController.tabBarController?.tabBar.barTintColor = FeedMe.white
        
    }

}