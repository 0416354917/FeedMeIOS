//
//  OrderTableViewController.swift
//  FeedMeIOS
//
//  Created by Jun Chen on 26/03/2016.
//  Copyright © 2016 FeedMe. All rights reserved.
//

import UIKit

class OrderTableViewController: UITableViewController, UIPopoverPresentationControllerDelegate, SSRadioButtonControllerDelegate {
    
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var deliveryFeeLabel: UILabel!
    @IBOutlet weak var totalFeeLabel: UILabel!
    @IBOutlet weak var deliveryAddressLabel: UILabel!
    
    @IBOutlet weak var addressSelectionView: UIView!
    
    
    var defaultDeliveryAddress: Address?
    var otherDeliveryAddresses = [Address]()
//    var radioButtons: [UIButton]?
//    var radioButtonController: SSRadioButtonsController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if FeedMe.Variable.order != nil {
            totalPrice.text = "$" + String(format: "%.2f", FeedMe.Variable.order!.totalPrice)
        } else {
            totalPrice.text = "$" + String(format: "%.2f", 0)
        }
        
        FeedMe.Variable.selectedDeliveryAddress = User().defaultDeliveryAddress!
        FeedMe.Variable.selectedDeliveryAddress.setAsSelected()
        deliveryAddressLabel.text = FeedMe.Variable.selectedDeliveryAddress.toSimpleAddressString()
        updateGrandTotalFee()
    
        loadAddresses()
        // configureRadioButtonView(addressSelectionView)
    }
    
    
    override func viewWillAppear(animated: Bool) {
        self.deliveryAddressLabel.text = FeedMe.Variable.selectedDeliveryAddress.toSimpleAddressString()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func updateGrandTotalFee() {
        var grandTotalString = deliveryFeeLabel.text!
        grandTotalString.removeAtIndex(grandTotalString.startIndex)
        let grandTotal = FeedMe.Variable.order!.totalPrice + Double(grandTotalString)!
        totalFeeLabel.text = "$" + String(format: "%.2f", grandTotal)
    }
    
    
    // MARK: - configure addresses selction view.
    
    /*
    func addRadioButton(view: UIView, _ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat, _ text: String ) -> SSRadioButton {
        
        let button = SSRadioButton()
        
        button.frame = CGRectMake(x, y, width, height)
        button.backgroundColor = UIColor(red: 0.82, green: 0.76, blue: 0.76, alpha: 1.0)
        button.setTitle(text, forState: UIControlState.Normal)
        button.titleLabel!.font = UIFont(name: "Times New Roman", size: 15)
        button.titleLabel!.textColor = UIColor.darkTextColor()
        button.addTarget(self, action: #selector(SSRadioButtonControllerDelegate.didSelectButton(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(button)
        
        print(view.frame.origin.x, view.frame.origin.y, view.frame.width, view.frame.height)
        print(button.frame.origin.x, button.frame.origin.y, button.frame.width, button.frame.height)
        
        return button
    }
    
    func configureRadioButtonView(view: UIView) {
        let x0 = view.frame.origin.x
        let y0 = view.frame.origin.y
        let width = view.frame.width
        let height = view.frame.height
        
        let radioButtonHeight = 50.0
        let firstRadioButton = addRadioButton(view, x0, y0, width, CGFloat(radioButtonHeight), defaultDeliveryAddress!.toSimpleAddressString())
        
        radioButtonController = SSRadioButtonsController(buttons: firstRadioButton)
        
        let circleRadius = 15
        var y = y0 + CGFloat(circleRadius * 3 + 1)
        for address in otherDeliveryAddresses {
            radioButtonController?.addButton(addRadioButton(view, x0, y, width, CGFloat(radioButtonHeight), address.toSimpleAddressString()))
            y += CGFloat(circleRadius * 3 + 1)
        }
        
        
        radioButtonController!.delegate = self
        radioButtonController!.shouldLetDeSelect = true
    }
    
    func didSelectButton(aButton: UIButton?) {
     
    }
    */
    
    /**
        To be changed.
        */
    func loadAddresses() {
        defaultDeliveryAddress = Address(userName: "CSIT", addressLine1: "108 N Rd", addressLine2: "Acton", postcode: "2601", phone: "(02) 6125 5111", suburb: "Canberra", state: "ACT", selected: true)
        
        let otherAddress1 = Address(userName: "Jason", addressLine1: "109 N Rd", addressLine2: "Acton", postcode: "2601", phone: "(02) 6125 5111", suburb: "Canberra", state: "ACT", selected: false)
        let otherAddress2 = Address(userName: "Jun Chen", addressLine1: "110 N Rd", addressLine2: "Acton", postcode: "2601", phone: "(02) 6125 5111", suburb: "Canberra", state: "ACT", selected: false)
        otherDeliveryAddresses += [otherAddress1]
        otherDeliveryAddresses += [otherAddress2]
    }
    
    
    // MARK: - IBActions.
    
    @IBAction func newAddressBtnClicked(sender: UIButton) {
        

    }
    
    
    // MARK: - Editing in the table view cell
    @IBAction func increaseBtn(sender: UIButton) {
        let cell = sender.superview!.superview! as! OrderTableViewCell
        FeedMe.Variable.order!.addDish(FeedMe.Variable.order!.id2dish[cell.tag]!, qty: 1)
        cell.dishQtyLabel.text = String(Int(cell.dishQtyLabel.text!)! + 1)
        totalPrice.text = "$" + String(format: "%.2f", FeedMe.Variable.order!.totalPrice)
        updateGrandTotalFee()
    }
    
    @IBAction func decreaseBtn(sender: UIButton) {
        let cell = sender.superview!.superview! as! OrderTableViewCell
        let newQty = Int(cell.dishQtyLabel.text!)! - 1
        FeedMe.Variable.order!.removeDish(cell.tag, qty: 1)
        if newQty == 0 {
            self.tableView.reloadData()
        } else {
            cell.dishQtyLabel.text = String(newQty)
        }
        totalPrice.text = "$" + String(format: "%.2f", FeedMe.Variable.order!.totalPrice)
        updateGrandTotalFee()
    }
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FeedMe.Variable.order!.id2dish.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "OrderTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! OrderTableViewCell

        // Configure the cell...
        let dish = FeedMe.Variable.order!.dishesList()[indexPath.row]
        cell.dishNameLabel.text = dish.name!
        cell.dishPriceLabel.text = "$" + String(format: "%.2f", Double(dish.price!))
        cell.dishQtyLabel.text = String(FeedMe.Variable.order!.id2count[dish.ID]!)
        
        cell.tag = dish.ID

        return cell
    }
    

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

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
