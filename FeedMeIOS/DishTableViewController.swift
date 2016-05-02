//
//  DishTableViewController.swift
//  FeedMeIOS
//
//  Created by Jun Chen on 19/03/2016.
//  Copyright © 2016 FeedMe. All rights reserved.
//

import UIKit

class DishTableViewController: UITableViewController {
    
    @IBOutlet weak var restaurantPhoto: UIImageView!
    @IBOutlet weak var cartIcon: UIBarButtonItem!
    
    // MARK: dishes stored according to their types.
    var entree = [Dish]()
    var soup = [Dish]()
    var dessert = [Dish]()
    var drinks = [Dish]()
    var others = [Dish]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restaurantPhoto.image = UIImage(named: "no_image_available.png")
        
        FeedMe.Variable.images = [String: UIImage]()
        FeedMe.Variable.order = Order(userID: FeedMe.Variable.userID, restaurantID: FeedMe.Variable.restaurantID!)
        FeedMe.Variable.dishes = [Int: Dish]()
        
        self.setBackground(self)
        self.setBar(self)
        
        navigationItem.title = FeedMe.Variable.restaurantName
        
        if Reachability.isConnectedToNetwork() {
            NSLog("User chooses restaurant with id = %@", String(FeedMe.Variable.restaurantID!))
            loadAllDishes(FeedMe.Path.TEXT_HOST + "dishes/query/?shopId=" + String(FeedMe.Variable.restaurantID!))
        } else {
            Reachability.alertNoInternetConnection(self)
        }
    }
    
    @IBAction func backToRestList(sender: UIBarButtonItem) {
        if FeedMe.Variable.order!.isEmptyOrder() {
           self.navigationController?.popViewControllerAnimated(true)
        } else {
            let alert = UIAlertController(title: "Tips", message: "Change to another restaurant will empty your current shopping cart, are you sure?", preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default) { (ACTION) in
                self.navigationController?.popViewControllerAnimated(true)
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil)
            
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func loadAllDishes(urlString: String) {
        NSLog("Loading data from url: %@", urlString)
        let url = NSURL(string: urlString)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {
            (myData, response, error) in
            
            dispatch_async(dispatch_get_main_queue(), {
                self.setDishInfo(myData!)
            })
        }
        
        task.resume()
    }
    
    func setDishInfo(dishData: NSData) {
        let json: Array<AnyObject>
        
        do {
            json = try NSJSONSerialization.JSONObjectWithData(dishData, options: .AllowFragments) as! Array<AnyObject>
            for index in 0...json.count-1 {
                
                if let ID = json[index]["id"] as?Int {
                    let shopID = json[index]["shopId"] as?Int
                    let type = json[index]["type"] as?String
                    let name = json[index]["name"] as?String
                    let description = json[index]["description"] as?String
                    
                    let ingredient = json[index]["ingredient"] as?String
                    let price = json[index]["price"] as?Int
                    let discount = json[index]["discount"] as?Int
                    let flavor = json[index]["flavor"] as?String
                    let sold = json[index]["sold"] as?Int
                    
                    var photo: UIImage?
                    
                    var dish = Dish(ID: ID, shopID: shopID, type: type, name: name, description: description, photo: photo, ingredient: ingredient, price: price, discount: discount, flavor: flavor, sold: sold)!
                    
                    // load image:
                    let photoName = json[index]["photo"] as?String
                    if photoName != nil {
                        if let _ = FeedMe.Variable.images![photoName!] {
                            photo = FeedMe.Variable.images![photoName!]
                            dish.setPhoto(photo)
                        } else {
                            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0), {
                                self.setImageInBG(&dish, photoName: photoName)
                            })
                        }
                    }

                    FeedMe.Variable.dishes[dish.ID] = dish
                    
                    switch dish.type! {
                    case DishType.Entree.rawValue:
                        entree += [dish]
                    case DishType.Soup.rawValue:
                        soup += [dish]
                    case DishType.Dessert.rawValue:
                        dessert += [dish]
                    case  DishType.Drinks.rawValue:
                        drinks += [dish]
                    default:
                        others += [dish]
                    }
                    
                }
            }
            
            entree.sortInPlace({$0.name! < $1.name!})
            soup.sortInPlace({$0.name! < $1.name!})
            dessert.sortInPlace({$0.name! < $1.name!})
            drinks.sortInPlace({$0.name! < $1.name!})
            others.sortInPlace({$0.name! < $1.name!})
            
            do_table_refresh()
            
        } catch _ {

        }
    }
    
    func setImageInBG(inout dish: Dish, photoName: String?) {
        let url = NSURL(string: FeedMe.Path.PICTURE_HOST + "img/photo/" + photoName!)
        let data = NSData(contentsOfURL : url!)
        let photo = UIImage(data : data!)
        
        dish.photo = photo!
        
        // Cache the newly loaded image:
        FeedMe.Variable.images![photoName!] = photo
        
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
        return 5
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return entree.count
        case 1:
            return soup.count
        case 2:
            return dessert.count
        case 3:
            return drinks.count
        case 4:
            return others.count
        default:
            return 0
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "DishTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! DishTableViewCell
        
        var dish: Dish!
        switch indexPath.section {
        case 0:
            dish = entree[indexPath.row]
        case 1:
            dish = soup[indexPath.row]
        case 2:
            dish = dessert[indexPath.row]
        case 3:
            dish = drinks[indexPath.row]
        case 4:
            dish = others[indexPath.row]
        default:
            break
        }
        
        cell.nameLabel.text = dish.name!
        cell.photoImageView.image = dish.photo
        
        cell.photoImageView.layer.cornerRadius = 10.0
        cell.photoImageView.layer.borderWidth = 0.0
        cell.photoImageView.clipsToBounds = true
        
        cell.addToShoppingCart.tag = dish.ID
        cell.addToShoppingCart.layer.borderWidth = 0
        cell.addToShoppingCart.layer.cornerRadius = 6.0
        
        cell.photoImageView.layer.cornerRadius = 10.0
        cell.photoImageView.layer.borderWidth = 0.0
        cell.photoImageView.clipsToBounds = true
        cell.backgroundColor = FeedMe.transColor7
        
        cell.addToShoppingCart.layer.cornerRadius = 5.0
        cell.addToShoppingCart.layer.borderColor = FeedMe.mainRed.CGColor
        cell.addToShoppingCart.layer.borderWidth = 1.0
        cell.addToShoppingCart.clipsToBounds = true
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case 0:
            FeedMe.Variable.dishID = entree[indexPath.row].ID
        case 1:
            FeedMe.Variable.dishID = soup[indexPath.row].ID
        case 2:
            FeedMe.Variable.dishID = dessert[indexPath.row].ID
        case 3:
            FeedMe.Variable.dishID = drinks[indexPath.row].ID
        case 4:
            FeedMe.Variable.dishID = others[indexPath.row].ID
        default:
            break
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return DishType.Entree.rawValue + " ( " + String(entree.count) + " )"
        case 1:
            return DishType.Soup.rawValue + " ( " + String(soup.count) + " )"
        case 2:
            return DishType.Dessert.rawValue + " ( " + String(dessert.count) + " )"
        case 3:
            return DishType.Drinks.rawValue + " ( " + String(drinks.count) + " )"
        case 4:
            return DishType.Others.rawValue + " ( " + String(others.count) + " )"
        default:
            return "Unclassfied"
        }
    }
    
    
    // Configure the header view.
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UITableViewHeaderFooterView()
        
        // MARK: TO BE CHANGED!
        // headerView.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        return headerView
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
