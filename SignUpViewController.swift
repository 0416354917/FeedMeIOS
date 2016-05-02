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
//    @IBOutlet weak var verificationCodeTextField: UITextField!
//    @IBOutlet weak var confirmButton: UIButton!
    
    var validEmail: String?
    var validVerificationCode: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        self.confirmButton.userInteractionEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonClicked(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func displayMessage(messgae: String) {
        let alert = UIAlertController(title: "Message", message: messgae, preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        
        alert.addAction(okAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }

    
    @IBAction func signUpButtonClicked(sender: UIButton) {
        validateSignUp()
    }
    
    //statusCode = 0: validate fail.
    //statusCode = 1: validate success.
    //description: validation result description.
    func validateSignUp() {
        NSLog("%@", "Validate sign up...")
        let validateUserInputResult = validateUserInput()
        if validateUserInputResult.statusCode == 0 {
            displayMessage(validateUserInputResult.description)
        } else {
            let urlString = FeedMe.Path.TEXT_HOST + "/users/checkEmail?email=" + emailTextField.text!
            let url = NSURL(string: urlString)
            let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {
                (data, response, error) in
                
                dispatch_async(dispatch_get_main_queue(), {
                    let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    NSLog("response: %@", responseString!)
                    
                    let json: NSDictionary
                    do {
                        json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
                        
                        if let statusInfo = json["statusInfo"] as? String {
                            if statusInfo == "N" {
                                FeedMeAlert.alertSignUpFailure(self, message: "Email is already taken")
                            } else if statusInfo == "Y" {
                                self.commitSignUp()
                            } else {
                                FeedMeAlert.alertSignUpFailure(self, message: "Unkown Error")
                            }
                        }
                        
                    } catch _ {
                        
                    }
                })
            }
            task.resume()
        }
    }
    
    func commitSignUp() {
        // MARK: TODO
        // Cache user data in local device settings once signing up successfully.
        // Prompt user whether allow current account automatically login next time.
        let hashPassword = Security.md5(string: passwordTextField.text!)
        let postString = "{\"email\":\"\(emailTextField.text!)\",\"password\":\"\(hashPassword)\"}"
        NSLog("post data: %@", postString)
        
        // Use EVReflection:
        let user = User(email: emailTextField.text!, password: hashPassword)
        user.setFirstName("default_firstname")
        user.setLastName("default_lastname")
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
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        task.resume()
    }

    func validateUserInput() -> (statusCode: Int, description: String) {
        NSLog("Validate user input...")
        
        let validateEmailResult = validateEmail()
        if validateEmailResult.statusCode == 0 {
            return validateEmailResult
        }
        
        let validatePasswordResult = validatePassword()
        if validatePasswordResult.statusCode == 0 {
            return validatePasswordResult
        }
        
        return (1, "")
    }
    
    func validateEmail() -> (statusCode: Int, description: String) {
        let email = emailTextField.text!
        NSLog("Validate email: %@", email)
        var statusCode = 1
        var description = ""
        // MARK: to be fixed!
        if email.length == 0 {
            // clear current input:
            passwordTextField.text = ""
            confirmPasswordTextField.text = ""
            statusCode = 0
            description = "Not a valid Email."
        }
        
        return (statusCode, description)
    }
    
    func validatePassword() -> (statusCode: Int, description: String) {
        let password = passwordTextField.text!
        let confirmPassword = confirmPasswordTextField.text!
        NSLog("Validate password: %@, confirm password: %@", password, confirmPassword)
        var statusCode = 1
        var description = ""
        if password.length == 0 || confirmPassword.length == 0 ||  password != confirmPassword {
            // clear current input:
            passwordTextField.text = ""
            confirmPasswordTextField.text = ""
            statusCode = 0
            description = "Password mismatch, enter again."
        }
        
        return (statusCode, description)
    }
  
    // MARK: - Not implemented now. To be implemented in the future.
    
    /*
    @IBAction func sendAgainButtonClicked(sender: UIButton) {
        sendVerificationCode(emailTextField.text!)
    }
 */
    
    /*
    @IBAction func confirmButtonClicked(sender: UIButton) {
        //        let validateVerificationCodeResult = validateVerificationCode(verificationCodeTextField.text)
        //        if validateVerificationCodeResult.statusCode == 0 {
        //            displayMessage(validateVerificationCodeResult)
        //        } else {
        //            commitSignUp()
        //        }
    }
 */
    
    /*
    func sendVerificationCode(phone: String) {
        // clear current input if any:
        verificationCodeTextField.text = ""
        verificationCodeTextField.becomeFirstResponder()
        
        // MARK: TODO: HTTP POST.
        // From the http response: get verification code and store in self.validVerificationCode.
        
        // uncomment the statement below and put it into callback handler:
        // self.confirmButton.userInteractionEnabled = true
        
    }
     */
    
    /*
    func validateVerificationCode(verificationCode: String?) -> (statusCode: Int, description: String) {
        var statusCode = 1
        var description = ""
        if verificationCode!.length == 0 || verificationCode! != self.validVerificationCode! {
            statusCode = 0
            description = "Wrong verification code."
        }
        
        return (statusCode, description)
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
