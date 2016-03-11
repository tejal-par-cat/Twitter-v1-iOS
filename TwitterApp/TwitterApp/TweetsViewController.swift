//
//  TweetsViewController.swift
//  TwitterApp
//
//  Created by Tejal Par on 9/28/14.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tweets: [Tweet]?
    
    @IBOutlet var logoutButton: UIBarButtonItem!
    
    @IBOutlet var newButton: UIBarButtonItem!
    
    @IBOutlet var tweetTableView: UITableView!
    
    var refreshControl: UIRefreshControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tweetTableView.dataSource = self
        self.tweetTableView.delegate = self
        
        self.tweetTableView.rowHeight=UITableViewAutomaticDimension
        self.tweetTableView.estimatedRowHeight = 83.0
        
        let pullToRefreshControl = UIRefreshControl()
        pullToRefreshControl.addTarget(self, action: "loadTweets", forControlEvents: UIControlEvents.ValueChanged)
        self.tweetTableView.insertSubview(pullToRefreshControl, atIndex: 0)
        self.refreshControl = pullToRefreshControl
        
        
        // Do any additional setup after loading the view.
        self.loadTweets()
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
        dispatch_get_main_queue(), closure)
    }
    
    func loadTweets(){
        
        delay(0, closure:{
            TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) -> () in
                self.tweets = tweets
                
                self.tweetTableView.reloadData()
                self.refreshControl?.endRefreshing()
            })
        })
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
        if self.tweets != nil{
            return self.tweets!.count
        }
        else{
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        
        var tweet = self.tweets?[indexPath.row] as Tweet!
        cell.userNameLabel.text = tweet.user?.name
        cell.tweetLabel.text = tweet.text
        cell.timestampLabel.text = tweet.createdAtString
        
        var profileImageURL = tweet.user?.profileImageUrl
        cell.profileImage.setImageWithURL(NSURL(string:profileImageURL!))
        
        return cell
    }

    @IBAction func onLogoutClick(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onComposeTweet(sender: AnyObject) {
        
    }
    override func dismissViewControllerAnimated(flag: Bool, completion: (() -> Void)?) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let indexPath = self.tweetTableView.indexPathForSelectedRow
        
        
        if(segue.identifier == "tweetDetailSegue"){
            var tweet = self.tweets?[indexPath!.row] as Tweet!
            let viewController = segue.destinationViewController as! TweetDetailViewController
            viewController.setupTweet(tweet)
        }
        
        
        if(segue.identifier == "composeSegue"){
            
            let viewController = segue.destinationViewController as! ComposeViewController
            viewController.setupUser(User.currentUser!)
        }
    }

}
