//
//  ComposeViewController.swift
//  TwitterApp
//
//  Created by Tejal Par on 9/29/14.
//

import UIKit

class ComposeViewController: UIViewController {

    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var taglineLabel: UILabel!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var tweetMsgTextview: UITextView!
    
    var userInfo: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadTweet()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSendTweet(sender: AnyObject) {
        
        let params = ["status": tweetMsgTextview.text]
        
        TwitterClient.sharedInstance.postTweet(params)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
   
    @IBAction func goBack(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func setupUser(user: User){
        self.userInfo = user
    }
    
    func loadTweet(){
        usernameLabel.text = self.userInfo?.name
        taglineLabel.text = self.userInfo?.tagLine
        
        let profileImageURL = self.userInfo?.profileImageUrl
        profileImage.setImageWithURL(NSURL(string:profileImageURL!))
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
