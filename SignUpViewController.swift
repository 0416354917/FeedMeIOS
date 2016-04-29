//
//  SignUpViewController.swift
//  FeedMeIOS
//
//  Created by Jun Chen on 11/04/2016.
//  Copyright © 2016 FeedMe. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var verificationCodeTextField: UITextField!
    @IBOutlet weak var confirmButton: UIButton!
    
    var validEmail: String?
    var validVerificationCode: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.confirmButton.userInteractionEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonClicked(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func displayMessage(validationResult: (statusCode: Int, description: String)) {
        let alert = UIAlertController(title: "Message", message: validationResult.description, preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        
        alert.addAction(okAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }

    
    @IBAction func signUpButtonClicked(sender: UIButton) {
        let validateSignUpResult = validateSignUp()
        if validateSignUpResult.statusCode == 0 {
            displayMessage(validateSignUpResult)
        } else {
            sendVerificationCode(emailTextField.text!)
        }
    }
    
    @IBAction func sendAgainButtonClicked(sender: UIButton) {
        sendVerificationCode(emailTextField.text!)
    }

    @IBAction func confirmButtonClicked(sender: UIButton) {
        let validateVerificationCodeResult = validateVerificationCode(verificationCodeTextField.text)
        if validateVerificationCodeResult.statusCode == 0 {
            displayMessage(validateVerificationCodeResult)
        } else {
            commitSignUp()
        }
    }
    
    
    //statusCode = 0: validate fail.
    //statusCode = 1: validate success.
    //description: validation result description.
    func validateSignUp() -> (statusCode: Int, description: String) {
        NSLog("%@", "validate sign up...")
        // (1) validate phone:
        let validateEmailResult = validateEmail(emailTextField.text)
        if validateEmailResult.statusCode == 0 {
            emailTextField.becomeFirstResponder()
            return validateEmailResult
        } else {
            self.validEmail = emailTextField.text
        }
        
        // (2) validate password:
        let validatePasswordResult = validatePassword(passwordTextField.text, confirmPassword: confirmPasswordTextField.text)
        if validatePasswordResult.statusCode == 0 {
            passwordTextField.becomeFirstResponder()
            return validatePasswordResult
        }
        
        // default return after all validation succeeded:
        return (1, "")
    }
    
    func validateEmail(email: String?) -> (statusCode: Int, description: String) {
        NSLog("validate phone number: %@", email!)
        var statusCode = 1
        var description = ""
        if email!.length != 10 {
            // clear current input:
            passwordTextField.text = ""
            confirmPasswordTextField.text = ""

            statusCode = 0
            description = "Not a valid Email."
        } else {
            // MARK:TODO: HTTP POST.
            // use main thread to do a HTTP POST to test match with database records.
        }
        
        return (statusCode, description)
    }
    
    func validatePassword(password: String?, confirmPassword: String?) -> (statusCode: Int, description: String) {
        NSLog("validate password: %@", password!)
        var statusCode = 1
        var description = ""
        if password!.length == 0 || confirmPassword!.length == 0 ||  password! != confirmPassword! {
            // clear current input:
            passwordTextField.text = ""
            confirmPasswordTextField.text = ""
            
            statusCode = 0
            description = "Password mismatch, enter again."
        }
        
        return (statusCode, description)
    }
    
    func sendVerificationCode(phone: String) {
        // clear current input if any:
        verificationCodeTextField.text = ""
        verificationCodeTextField.becomeFirstResponder()
        
        // MARK: TODO: HTTP POST.
        // From the http response: get verification code and store in self.validVerificationCode.
        
        // uncomment the statement below and put it into callback handler:
        // self.confirmButton.userInteractionEnabled = true
        
    }
    
    func validateVerificationCode(verificationCode: String?) -> (statusCode: Int, description: String) {
        var statusCode = 1
        var description = ""
        if verificationCode!.length == 0 || verificationCode! != self.validVerificationCode! {
            statusCode = 0
            description = "Wrong verification code."
        }
        
        return (statusCode, description)
    }
    
    func commitSignUp() {
        // MARK: TODO: HTTP POST.
        // Cache user data in local device settings once signing up successfully.
        // Prompt user whether allow current account automatically login next time.
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
