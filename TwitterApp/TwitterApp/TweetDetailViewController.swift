//
//  TweetDetailViewController.swift
//  TwitterApp
//
//  Created by Tejal Par on 9/29/14.
//

import UIKit

class TweetDetailViewController: UIViewController {

    
   
    @IBOutlet var usernameLabel: UILabel!
    
    @IBOutlet var tweetLabel: UILabel!
    
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var favLabel: UILabel!
    @IBOutlet var timestampLabel: UILabel!
    @IBOutlet var tagLabel: UILabel!
    @IBOutlet var retweetLabel: UILabel!
    
    var tweetInfo: Tweet?
    var window: UIWindow?
    var storyboard1 =  UIStoryboard(name: "Main", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadTweet()
        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupTweet(tweet: Tweet){
        
        self.tweetInfo = tweet
        
    }
    
    func loadTweet(){
        usernameLabel.text = self.tweetInfo?.user?.name
        tagLabel.text = self.tweetInfo?.user?.tagLine
        tweetLabel.text = self.tweetInfo?.text
        retweetLabel.text = self.tweetInfo?.retweetCount?.stringValue
        favLabel.text = self.tweetInfo?.favoriteCount?.stringValue
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        let date = self.tweetInfo?.createdAt
        let datestring = formatter.stringFromDate(date!)
        
        //var datastring = NSString(self.tweetInfo?.createdAt, encoding: UInt.self)
        
        timestampLabel.text = datestring //self.tweetInfo?.createdAt.
        let profileImageURL = self.tweetInfo?.user?.profileImageUrl
        profileImage.setImageWithURL(NSURL(string:profileImageURL!))
    }
    

    @IBAction func onHomeClick(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
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
