//
//  NewAddressViewController.swift
//  FeedMeIOS
//
//  Created by Jun Chen on 30/03/2016.
//  Copyright © 2016 FeedMe. All rights reserved.
//

import UIKit

class NewAddressViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var addressLine1TextField: UITextField!
    @IBOutlet weak var addressLine2TextField: UITextField!
    @IBOutlet weak var suburbTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var postalCodeTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    // MARK: - Properties
    var address: Address?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonClicked(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    /*
    // MARK: - UITextFieldDelegate
    
    func textFieldDidBeginEditing(textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.enabled = false
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        validateInput()
    }
    
    func validateInput() {
        saveButton.enabled = true
    }
     */
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if saveButton === sender {
            let userName = userNameTextField.text!
            let addressLine1 = addressLine1TextField.text!
            let addressLine2 = addressLine2TextField.text!
            let suburb = suburbTextField.text!
            let state = stateTextField.text!
            let postalCode = postalCodeTextField.text!
            let phone = phoneTextField.text!
            
            address = Address(userName: userName, addressLine1: addressLine1, addressLine2: addressLine2, postcode: postalCode, phone: phone, suburb: suburb, state: state, selected: true)
        }
    }

}
