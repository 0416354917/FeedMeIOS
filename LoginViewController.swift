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
    
    @IBAction func signInButtonClicked(sender: UIButton) {
        let verifyResult = verifyUser(usernameTextField.text, inputPassword: passwordTextField.text)
        print(usernameTextField.text, " ", passwordTextField.text)
    }
    
    func verifyUser(inputUsername: String?, inputPassword: String?) -> Bool {
        
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
