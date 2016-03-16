//
//  RestaurantTableViewController.swift
//  FeedMeIOS
//
//  Created by Jun Chen on 16/03/2016.
//  Copyright © 2016 FeedMe. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    
    // MARK: Properties
    
    let TEXT_HOST = "http://ec2-52-27-149-51.us-west-2.compute.amazonaws.com:8080/"
    let PICTURE_HOST = "http://ec2-52-27-149-51.us-west-2.compute.amazonaws.com:8080/"
    
    var restaurantID = [String]()
    var restaurants = [Restaurant]()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Load the sample data.
        loadRestaurants()
        
        // Change the backgroud color of the tab bar:
        // self.tabBarController?.tabBar.backgroundColor = UIColor.redColor()
        // self.tabBarController?.tabBar.barTintColor = UIColor.redColor()
    }
    
    func loadRestaurants() {
        // Retrieve the list of all online shops' IDs:
        var shopIDs = [String]()
        shopIDs.append("1")
        shopIDs.append("17")
        shopIDs.append("18")
        shopIDs.append("19")
        shopIDs.append("20")
        shopIDs.append("21")
        shopIDs.append("22")
        
        for shopID in shopIDs {
            getShopData("http://ec2-52-27-149-51.us-west-2.compute.amazonaws.com:8080/restaurants/query/?id=" + shopID)
        }
        
//        getShopData

//        let photo1 = UIImage(named: "rest1")!
//        let restaurant1 = Restaurant(name: "Caprese Salad", photo: photo1, openTime: "10:00")!
//        
//        let photo2 = UIImage(named: "rest2")!
//        let restaurant2 = Restaurant(name: "Chicken and Potatoes", photo: photo2, openTime: "10:00")!
//        
//        let photo3 = UIImage(named: "rest3")!
//        let restaurant3 = Restaurant(name: "Pasta with Meatballs", photo: photo3, openTime: "10:00")!
//        
//        restaurants += [restaurant1, restaurant2, restaurant3]
    }
    
    // MARK: Functions to retrieve data from databse.
//    func retrieveOnlineShops(urlString: String) {
//        // Retrieve data from database:
//        let url = NSURL(string: urlString)
//        
//        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {
//            (myData, response, error) in
//            
//            dispatch_async(dispatch_get_main_queue(), {
//                self.setShopInfo(myData!)
//            })
//        }
//        
//        task.resume()
//    }
    
    func getShopData(urlString: String) {
        let url = NSURL(string: urlString)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {
            (myData, response, error) in
            
            dispatch_async(dispatch_get_main_queue(), {
                self.setShopInfo(myData!)
            })
        }
        
        task.resume()
    }
    
    func setShopInfo(shopData: NSData) {
        let json: NSDictionary
        do {
            json = try NSJSONSerialization.JSONObjectWithData(shopData, options: .AllowFragments) as! NSDictionary
            
            if let name = json["name"] as? String,  openTimeMorning = json["openTimeMorning"] as?String{
                
                let restaurant = Restaurant(name: name, photo: nil, openTime: openTimeMorning)!
                
                restaurants += [restaurant]
                
                do_table_refresh()
            }
        } catch _ {
            
        }
        
    }
    
    func do_table_refresh()
    {
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
            return
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "RestaurantTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RestaurantTableViewCell
        
        // Fetches the appropriate meal for the data source layout.
        let restaurant = restaurants[indexPath.row]
        
        cell.nameLabel.text = restaurant.name
        cell.photoImageView.image = restaurant.photo
        cell.timeLabel.text = restaurant.openTime
        
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
