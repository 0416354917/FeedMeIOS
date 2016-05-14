//
//  PaymentViewController.swift
//  FeedMeIOS
//
//  Created by Jun Chen on 7/05/2016.
//  Copyright © 2016 FeedMe. All rights reserved.
//

import UIKit

class PaymentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ConfirmButtonClicked(sender: UIButton) {
        if FeedMe.Variable.userInLoginState {
//            NSLog("user id: %@", String(FeedMe.Variable.userID!))
            self.postOrder()
        } else {
            // create a new user with machice id and then POST with new user
            FeedMe.Variable.order!.userID = 1
            self.createNewUserWithCurrentDeviceID()
        }
    }

    
    func createNewUserWithCurrentDeviceID() {
        let hashPassword = Security.md5(string: "1234")
    
        // Use EVReflection:
        let user = User(email: "machine1@feedme.com", password: hashPassword)
        user.setFirstName("default_firstname")
        user.setLastName("default_lastname")
        user.setMachineCode(UIDevice.currentDevice().identifierForVendor!.UUIDString)
        //
//        user.id
    
        let jsonString = user.toJsonString(ConvertionOptions.None)
        NSLog("json string: %@", jsonString)
        
        let url = FeedMe.Path.TEXT_HOST + "users/register"
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = "POST"
        request.HTTPBody = jsonString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // NSLog("reuqest body: %@", request.HTTPBody!)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {
                // check for fundamental networking error
                NSLog("error: %@", error!)
                FeedMeAlert.alertSignUpFailure(self, message: "Unknown error")
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {
                // check for http errors
                NSLog("statusCode should be 200, but is: %@", httpStatus.statusCode)
                NSLog("response: %@", response!)
                FeedMeAlert.alertSignUpFailure(self, message: "Unknown error")
                return
            }
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            NSLog("response string: %@", responseString!)
            
            FeedMe.user = user
            FeedMe.Variable.userInLoginState = true
            
            self.postOrder()
        }
        task.resume()
    }
    
    
    func postOrder() {
        let postOrder = PostOrder(order: FeedMe.Variable.order)
        NSLog("post order: %@", postOrder.toJsonString(ConvertionOptions.None))
        
        let jsonString = postOrder.toJsonString(ConvertionOptions.None)
        
        let url = FeedMe.Path.TEXT_HOST + "orders/create"
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = "POST"
        request.HTTPBody = jsonString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // NSLog("reuqest body: %@", request.HTTPBody!)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {
                // check for fundamental networking error
                NSLog("error: %@", error!)
                FeedMeAlert.alertSignUpFailure(self, message: "Unknown error")
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {
                // check for http errors
                NSLog("statusCode should be 200, but is: %@", httpStatus.statusCode)
                NSLog("response: %@", response!)
                FeedMeAlert.alertSignUpFailure(self, message: "Unknown error")
                return
            }
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            NSLog("response string: %@", responseString!)
        }
        task.resume()
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
