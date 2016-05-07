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
    var restaurants = [Restaurant]()

    
    override func viewDidLoad() {
        super.viewDidLoad()   
        
        
        // Device ID
        NSLog("Device ID: %@", UIDevice.currentDevice().identifierForVendor!.UUIDString)
        
        // Initialization:
        FeedMe.Variable.images = [String: UIImage]()
        
        self.setBackground(self)
        self.setBar(self)

        // Load the data:
        if Reachability.isConnectedToNetwork() {
            loadAllRestaurants(FeedMe.Path.TEXT_HOST + "restaurants/allRestaurant")
        } else {
            Reachability.alertNoInternetConnection(self)
        }
    }
        
    func loadAllRestaurants(urlString: String) {
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
        let json: Array<AnyObject>
        
        do {
            json = try NSJSONSerialization.JSONObjectWithData(shopData, options: .AllowFragments) as! Array<AnyObject>
            
            for index in 0...json.count-1 {
                
                if let ID = json[index]["id"] as?Int {
                    let name = json[index]["name"] as?String
                    let description = json[index]["description"] as?String
                    let type = json[index]["type"] as?String
                    let phone = json[index]["phone"] as?String
                    let email = json[index]["email"] as?String
                    let openTimeMorning = json[index]["openTimeMorning"] as?String
                    let openTimeAfternoon = json[index]["openTimeAfternoon"] as?String
                    // let checkin = json[index]["checkin"] as?Bool
                    let checkin = true // MARK: TO BE CHANGED!
                    
                    // load image:
                    let logoName = json[index]["logo"] as?String
                    var image: UIImage?
                
                    var restaurant = Restaurant(ID: ID, name: name, logo: image, description: description, type: type, phone: phone, email: email, openTimeMorning: openTimeMorning, openTimeAfternoon: openTimeAfternoon, checkin: checkin)!

                    if logoName != nil {
                        if let _ = FeedMe.Variable.images![logoName!] {
                            image = FeedMe.Variable.images![logoName!]
                            restaurant.setLogo(image)
                        } else {
                            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0), {
                                self.setImageInBG(&restaurant, logoName: logoName)
                            })
                        }
                    }

                    restaurants += [restaurant]
                }
            }
            
            do_table_refresh()
        } catch _ {
            Reachability.alertNoInternetConnection(self)
        }
    }
    
    func setImageInBG(inout restaurant: Restaurant, logoName: String?) {
        let url = NSURL(string: FeedMe.Path.PICTURE_HOST + "img/logo/" + logoName!)
        let data = NSData(contentsOfURL : url!)
        let image = UIImage(data : data!)
        
        restaurant.logo = image!
        
        // Cache the newly loaded image:
        FeedMe.Variable.images![logoName!] = image
        
        do_table_refresh()
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
        FeedMe.Variable.images?.removeAll()
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
        cell.typeLabel.text = restaurant.type
        cell.photoImageView.image = restaurant.logo
        
        cell.photoImageView.layer.cornerRadius = 10.0
        cell.photoImageView.layer.borderWidth = 2.0
        cell.photoImageView.clipsToBounds = true
        if((indexPath.row)%2 == 0) {
            cell.backgroundColor = FeedMe.transColor4
            cell.photoImageView.layer.borderColor = FeedMe.transColor4.CGColor
            
            
        } else {
            cell.backgroundColor = FeedMe.transColor7
            cell.photoImageView.layer.borderColor = FeedMe.transColor7.CGColor
        }
        
        if restaurant.openTimeMorning != nil && restaurant.openTimeAfternoon != nil {
            cell.timeLabel.text = restaurant.openTimeMorning! + "\n" + restaurant.openTimeAfternoon!
        } else {
            cell.timeLabel.text = ""
        }
        
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let restaurant = restaurants[indexPath.row]
        FeedMe.Variable.restaurantID = restaurant.ID
        FeedMe.Variable.restaurantName = restaurant.name
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
