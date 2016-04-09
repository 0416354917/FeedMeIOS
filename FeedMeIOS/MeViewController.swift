//
//  MeViewController.swift
//  FeedMeIOS
//
//  Created by Jun Chen on 5/04/2016.
//  Copyright © 2016 FeedMe. All rights reserved.
//

import UIKit

class MeViewController: UIViewController {
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setViewBackground(self)
        self.setViewBar(self)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(animated: Bool) {
        let gap = 80
        
        signInButton.frame = CGRectMake(self.view.frame.size.width/2 - signInButton.frame.size.width/2, self.view.frame.size.height/2 - signInButton.frame.size.height/2, signInButton.frame.size.width, signInButton.frame.size.height)
        signUpButton.frame = CGRectMake(self.view.frame.size.width/2 - signUpButton.frame.size.width/2, self.view.frame.size.height/2 - signUpButton.frame.size.height/2 + CGFloat(gap), signUpButton.frame.size.width, signUpButton.frame.size.height)
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
