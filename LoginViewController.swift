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
        
        let verifyUserResult = verifyUser(usernameTextField.text, inputPassword: passwordTextField.text)
        
        if verifyUserResult == false {
            usernameTextField.text = ""
            passwordTextField.text = ""
            usernameTextField.becomeFirstResponder()
            
            displayMessage("Wrong username or password. Try again.")
        } else {
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func verifyUser(inputUsername: String?, inputPassword: String?) -> Bool {
        // MARK: TODO HTTP POST.
        
        return false
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
