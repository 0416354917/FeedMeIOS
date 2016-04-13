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
        
        let verifyUserLoginResult = verifyUserLogin(usernameTextField.text, inputPassword: passwordTextField.text)
        
        if verifyUserLoginResult.statusCode == 0 {
            usernameTextField.text = ""
            passwordTextField.text = ""
            usernameTextField.becomeFirstResponder()
            
            displayMessage(verifyUserLoginResult.description)
        } else {
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func verifyUsername(inputUsername: String?) -> (statusCode: Int, description: String) {
        var statusCode = 0
        var description = "Invalid username. Username does not exist."
        
        // MARK: TODO HTTP POST (use main thread).
        // if username exists, return (statusCode = 1, description = password).
        
        return (statusCode, description)
    }
    
    func verifyUserLogin(inputUsername: String?, inputPassword: String?) -> (statusCode: Int, description: String) {
        var statusCode = 0
        var description = ""
        
        // (1) verify username:
        let verifyUsernameResult = verifyUsername(inputUsername)
        if verifyUsernameResult.statusCode == 0 {
            usernameTextField.text = ""
            passwordTextField.text = ""
            usernameTextField.becomeFirstResponder()
            
            statusCode = 0
            description = verifyUsernameResult.description
        }
        
        // (2) verify password:
        else if passwordTextField.text! != verifyUsernameResult.description{
            passwordTextField.text = ""
            usernameTextField.becomeFirstResponder()
            
            statusCode = 0
            description = "Wrong username or wrong password. Try again."
        } else {
            statusCode = 1
            description = ""
        }
        
        return (statusCode, description)
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
