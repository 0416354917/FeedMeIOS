//
//  RetrievePasswordViewController.swift
//  FeedMeIOS
//
//  Created by Jun Chen on 7/04/2016.
//  Copyright © 2016 FeedMe. All rights reserved.
//

import UIKit

class RetrievePasswordViewController: UIViewController {

    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayMessage(validationResult: (statusCode: Int, description: String)) {
        let alert = UIAlertController(title: "Message", message: validationResult.description, preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        
        alert.addAction(okAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func phoneButtonClicked(sender: UIButton) {
    }
    

    @IBAction func emailButtonClicked(sender: UIButton) {
    }
    
    @IBAction func confirmButtonClicked(sender: UIButton) {
    }
    
    @IBAction func sendAgainButtonClicked(sender: UIButton) {
    }
    
    
    
    func sendVerificationCode(phone: String) {
        // clear current input if any:
        
        // MARK: TODO: HTTP POST.
        // From the http response: get verification code and store in self.validVerificationCode.
        
        // uncomment the statement below and put it into callback handler:
        // self.confirmButton.userInteractionEnabled = true
        
    }
    
    func validateVerificationCode(verificationCode: String?) -> (statusCode: Int, description: String) {
        var statusCode = 1
        var description = ""
        
        return (statusCode, description)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
