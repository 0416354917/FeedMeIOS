//
//  HistoryOrdersTableViewController.swift
//  FeedMeIOS
//
//  Created by Jun Chen on 3/04/2016.
//  Copyright © 2016 FeedMe. All rights reserved.
//

import UIKit

class HistoryOrdersTableViewController: UITableViewController {

    var historyOrders: HistoryOrders?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setBackground(self)
        self.setBar(self)

        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        if Reachability.isConnectedToNetwork() {
            self.loadData()
        } else {
            Reachability.alertNoInternetConnection(self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Load data source
    // TODO: HTTP GET
    func loadData() -> Bool {
        var currentOrders:[Order]? = [Order]()
        let curOrder1 = Order(userID: FeedMe.Variable.userID, restaurantID: 1)
        curOrder1.totalPrice = 100
        curOrder1.setTime()
        currentOrders = currentOrders! + [curOrder1]
        
        var pastOrders:[Order]? = [Order]()
        let pastOrder1 = Order(userID: FeedMe.Variable.userID, restaurantID: 1)
        pastOrder1.totalPrice = 200
        pastOrder1.setTime()
        pastOrders = pastOrders! + [pastOrder1]
        
        historyOrders = HistoryOrders(currentOrders: currentOrders, pastOrders: pastOrders)

        return true
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return historyOrders!.getCurrentOrders()!.count
        case 1:
            return historyOrders!.getPastOrders()!.count
        default:
            return 0
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "HistoryOrdersTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! HistoryOrdersTableViewCell

        // Configure the cell...
        var order: Order?
        
        switch indexPath.section {
        case 0:
            order = historyOrders!.getCurrentOrders()![indexPath.row]
            cell.OrderStateLabel.text = "Being Cooked"
        case 1:
            order = historyOrders!.getPastOrders()![indexPath.row]
            cell.OrderStateLabel.text = "Finished"
        default:
            break
        }
        
        if((indexPath.row)%2 == 0) {
            cell.backgroundColor = FeedMe.transColor4
        } else {
            cell.backgroundColor = FeedMe.transColor7
        }
        
        cell.GrandTotalLabel.text = "$\(order!.totalPrice)"
        cell.OrderDateLabel.text = order!.orderTime!
        

        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Current Feeds (\(historyOrders!.getCurrentOrders()!.count))"
        case 1:
            return "Past Feeds (\(historyOrders!.getPastOrders()!.count))"
        default:
            return ""
        }
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        switch indexPath.section {
        case 0:
            return false
        case 1:
            return true
        default:
            false
        }
        
        return false
    }


    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            historyOrders!.delete("HISTORY", index: indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            // Update header information of the history orders section
            tableView.reloadSections(NSIndexSet(index: 1), withRowAnimation: UITableViewRowAnimation.None)
        }
    }
    

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
