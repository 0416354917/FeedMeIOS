//
//  AddressTableViewController.swift
//  FeedMeIOS
//
//  Created by Jun Chen on 28/03/2016.
//  Copyright © 2016 FeedMe. All rights reserved.
//

import UIKit

class AddressTableViewController: UITableViewController {
    
    var defaultDeliveryAddress: Address?
    var otherDeliveryAddresses = [Address]()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadAddresses()
    }
    
    /**
        To be changed.
        */
    func loadAddresses() {
        // Construct some test data:
        // MARK: change this to load data from remote database:
        defaultDeliveryAddress = Address(userName: "CSIT", addressLine1: "108 N Rd", addressLine2: "Acton", postcode: "2601", phone: "(02) 6125 5111", suburb: "Canberra", state: "ACT", selected: true)
        
        let otherAddress1 = Address(userName: "Jason", addressLine1: "37 Chandler St", addressLine2: "Belconnen", postcode: "2617", phone: "(04) 1635 4917", suburb: "Canberra", state: "ACT", selected: false)
        let otherAddress2 = Address(userName: "Jun Chen", addressLine1: "4 Eady St", addressLine2: "Dickson", postcode: "2602", phone: "(04) 1635 4917", suburb: "Canberra", state: "ACT", selected: false)
        otherDeliveryAddresses += [otherAddress1]
        otherDeliveryAddresses += [otherAddress2]
    }

    
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
            return otherDeliveryAddresses.count
        default:
            return 0
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "AddressTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! AddressTableViewCell
    
        // Fetch the data entry:
        var address: Address?
        switch indexPath.section {
        case 0:
            address = defaultDeliveryAddress
            
        case 1:
            address = otherDeliveryAddresses[indexPath.row]
        default:
            address = nil
        }
        
        // Configure the cell...
        if address!.toFormattedString() == FeedMe.Variable.selectedDeliveryAddress.toFormattedString() {
            cell.deliveryAddressLabel.textColor = UIColor(red: 1, green: 165/255, blue: 0, alpha: 1)
        } else {
            cell.deliveryAddressLabel.textColor = nil
        }
        
        cell.deliveryAddressLabel.text = address!.toFormattedString()
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case 0:
            FeedMe.Variable.selectedDeliveryAddress.setAsDeselected()
            FeedMe.Variable.selectedDeliveryAddress = defaultDeliveryAddress!
            FeedMe.Variable.selectedDeliveryAddress.setAsSelected()
        case 1:
            FeedMe.Variable.selectedDeliveryAddress.setAsDeselected()
            FeedMe.Variable.selectedDeliveryAddress = otherDeliveryAddresses[indexPath.row]
            FeedMe.Variable.selectedDeliveryAddress.setAsSelected()
        default:
            break
        }
        
        // self.tableView.reloadData()
        self.navigationController!.popViewControllerAnimated(true)
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Default Delivery Address"
        case 1:
            return "Other Delivery Address(es)"
        default:
            return nil
        }
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // MARK: To be cconfigured.
        return nil
    }
    
    
    @IBAction func unwindToAddressList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? NewAddressViewController, address = sourceViewController.address {
            let newIndexPath = NSIndexPath(forRow: otherDeliveryAddresses.count, inSection: 1)
            otherDeliveryAddresses.append(address)
            FeedMe.Variable.selectedDeliveryAddress.setAsDeselected()
            FeedMe.Variable.selectedDeliveryAddress = address
            FeedMe.Variable.selectedDeliveryAddress.setAsSelected()
            self.tableView.beginUpdates()
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            self.tableView.endUpdates()
        }
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
