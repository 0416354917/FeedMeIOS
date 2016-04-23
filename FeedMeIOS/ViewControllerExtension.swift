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
        let bgImage = UIImage(named:"background.png")
        let imageView = UIImageView(frame: viewController.view.bounds)
        imageView.image = bgImage
        viewController.tableView.backgroundView = imageView
        
    }
    func setBar(viewTableController:UITableViewController){
        let nav = viewTableController.navigationController?.navigationBar
        
        nav?.tintColor = UIColor.whiteColor()
        nav?.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        
        let ngColor = UIColor(red: 203/255, green:41/225, blue: 10/255, alpha: 1)
        nav?.backgroundColor = ngColor
        nav?.barTintColor = ngColor
        viewTableController.tabBarController?.tabBar.backgroundColor = ngColor
        viewTableController.tabBarController?.tabBar.barTintColor = ngColor
    }
}

extension UIViewController{
    func setViewBackground(viewController:UIViewController){
//        let bgImage = UIImage(named:"background.png")
//        let imageView = UIImageView(frame: viewController.view.bounds)
//        imageView.image = bgImage
        
        viewController.view.backgroundColor = UIColor(patternImage: UIImage(named:"background.png")!)
    }
    func setViewBar(viewController:UIViewController){
        let nav = viewController.navigationController?.navigationBar
        
        nav?.tintColor = UIColor.whiteColor()
        nav?.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        
        let ngColor = UIColor(red: 203/255, green:41/225, blue: 10/255, alpha: 1)
        nav?.backgroundColor = ngColor
        nav?.barTintColor = ngColor
        viewController.tabBarController?.tabBar.backgroundColor = ngColor
        viewController.tabBarController?.tabBar.barTintColor = ngColor
    }

}