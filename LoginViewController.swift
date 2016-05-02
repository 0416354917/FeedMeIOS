//
//  LoginViewController.swift
//  FeedMeIOS
//
//  Created by Jun Chen on 9/04/2016.
//  Copyright © 2016 FeedMe. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    var loginStatus: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayMessage(message: String) {
        let alert = UIAlertController(title: "Message", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        
        alert.addAction(okAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }

    @IBAction func closeButtonClicked(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func signInButtonClicked(sender: UIButton) {
        NSLog("username: %@, password: %@", usernameTextField.text!, passwordTextField.text!)
        
        let hashPassword = Security.md5(string: passwordTextField.text!)
        NSLog("hash password: %@", hashPassword)

        let urlString: String = FeedMe.Path.TEXT_HOST + "users/login?email=\(usernameTextField.text!)&pwd=\(hashPassword)"
        
        validateUserLogin(urlString)
    }
    
    
    func validateUserLogin(urlString: String) {
        let url = NSURL(string: urlString)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {
            (myData, response, error) in
            
            dispatch_async(dispatch_get_main_queue(), {
                let json: NSDictionary
                
                do {
                    json = try NSJSONSerialization.JSONObjectWithData(myData!, options: .AllowFragments) as! NSDictionary
                    
                    if let statusInfo = json["statusInfo"] as? String {
                        if statusInfo == "Y" {
                            NSLog("Login Success!")
                            self.loginStatus = true
                            FeedMe.Variable.userInLoginState = true
                            self.dismissViewControllerAnimated(true, completion: nil)
                        } else {
                            NSLog("Login Fail!")
                            self.displayMessage("Incorrect email address or password!")
                        }
                    }
                } catch _ {
                    
                }

            })
        }
        task.resume()
    }
    
    
    @IBAction func forgetPasswordButtonClicked(sender: UIButton) {
        
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
