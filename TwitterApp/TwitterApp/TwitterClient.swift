//
//  TwitterClient.swift
//  TwitterApp
//
//  Created by Tejal Par on 9/28/14.
//

import UIKit

let twitterConsumerKey = "0talugHpBiMETq8fCImDbYPAx"
let twitterConsumerSecret = "KkgQd9qO7pDVZyvG2DUN4gsx6sjL7NKQFk4fTIcPFO8N87akpA"
let twitterBaseUrl = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1RequestOperationManager {
    
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseUrl, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
            
            return Static.instance
    }
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()){
        self.loginCompletion = completion
        
        
        //1. Get request token
        //2. Build auth URL using Request token & Open URL (Authorize URL step)
        //3. Get Access token
        
        
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        fetchRequestTokenWithPath("oauth/request_token", method: "GET",
            callbackURL: NSURL(string: "cptwitterdemo2://oauth"), scope: nil,
            success: { (requestToken: BDBOAuthToken!) -> Void in
                
                print("Request token: \(requestToken)")
                var authURL = "https:api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)"
                UIApplication.sharedApplication().openURL(NSURL(string: authURL)!)
                
                
            })
            { (error: NSError!) -> Void in
                print("Failure: \(error)")
                self.loginCompletion?(user: nil, error: error)
        }
    }
    
    func homeTimelineWithParams(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()){
        
        //timeline status api
        //TwitterClient.sharedInstance.GET("1.1/statuses/home_timeline.json", parameters: nil,
        GET("1.1/statuses/home_timeline.json", parameters: nil,
            success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
               // println("Timeline info: \(response)")
                
                var tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
                completion(tweets: tweets, error: nil)
                
//                for tweet in tweets{
//                    println("Tweet: \(tweet.text), created: \(tweet.createdAt)")
//                }
                
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                print("Error: \(error)")
                completion(tweets: nil, error: error)
        })
    }
    
    
    
    func postTweet(params: NSDictionary?){
        
        //timeline status api
        //TwitterClient.sharedInstance.GET("1.1/statuses/home_timeline.json", parameters: nil,
        POST("1.1/statuses/update.json", parameters: params,success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            print("Upadte info: \(response)")
            
            
            
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                print("Error: \(error)")
                
        })
    }

    
    func openURL(url: NSURL){
        //1. Access twitter singleton
        //2. Fetch access token
        //3. Save access token
        
        //twitter hands us back the request token with the URL
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuthToken(queryString: url.query), success: { (accessToken: BDBOAuthToken!) -> Void in
            print("Received access token: \(accessToken)")
            
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            
            //Verify Credentials api
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil,
                success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                    //println("User info: \(response)")
                    var user = User(dictionary: response as! NSDictionary)
                    User.currentUser = user
                   print("User: \(user.name)")
                    self.loginCompletion?(user: user, error: nil)
                    
                }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                    print("Error getting current user: \(error)")
                    self.loginCompletion?(user: nil, error: error)
            })
            
            
        })
        { (error: NSError!) -> Void in
                print("Error: \(error)")
                self.loginCompletion?(user: nil, error: error)
        }
    }
   
}
