//
//  ViewController.swift
//  TwitterApp
//
//  Created by Tejal Par on 9/28/14.
//

import UIKit

class ViewController: UIViewController {
    
    //let twitterConsumerKey = "lvRAEwJEZYcPlyCBaQvfj9UOD"
    //let twitterConsumerSecret = "cFyb1Ae86fqMK8QnJ2MoFlmp8sD8pyZ1lheF57a7wgIBOMFOOH"
    //let twitterAppUrl = "https://apps.twitter.com"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogin(sender: AnyObject) {
        
        
        TwitterClient.sharedInstance.loginWithCompletion(){
            (user: User?, error: NSError?) in
            if user != nil{
                //perform segue
                self.performSegueWithIdentifier("loginSegue", sender: self)
            }
            else{
                
            }
        }
        
    }

}

