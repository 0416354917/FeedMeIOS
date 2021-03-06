//
//  MeTableViewController.swift
//  FeedMeIOS
//
//  Created by Jun Chen on 11/04/2016.
//  Copyright © 2016 FeedMe. All rights reserved.
//

import UIKit

class MeTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setBackground(self)
        self.setBar(self)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        if FeedMe.Variable.userInLoginState == false {
            let nextViewController = self.storyboard!.instantiateViewControllerWithIdentifier("sign_in_up")
            self.presentViewController(nextViewController, animated: true, completion: nil)
        } else {
            self.tableView.reloadData()
        }
    }
    
//    override func viewWillAppear(animated: Bool) {
//        if FeedMe.Variable.userInLoginState == false {
//            let nextViewController = self.storyboard!.instantiateViewControllerWithIdentifier("sign_in_up")
//            self.presentViewController(nextViewController, animated: true, completion: nil)
//        }
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        default:
            return 0
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "MeTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MeTableViewCell

        // Configure the cell...
        if FeedMe.user == nil {
            cell.itemLabel.text = ""
            return cell
        }
        
        NSLog("user: %@", FeedMe.user!.toJsonString(.None))
        
        switch indexPath.section {
        case 0:
            cell.itemLabel.text = FeedMe.user!.getEmail()
        case 1:
            cell.itemLabel.text = "Settings"
        default:
            cell.itemLabel.text = ""
        }
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
