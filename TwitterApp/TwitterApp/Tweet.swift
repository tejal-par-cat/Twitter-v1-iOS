//
//  Tweet.swift
//  TwitterApp
//
//  Created by Tejal Par on 9/28/14.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var retweetCount: NSNumber?
    var favoriteCount: NSNumber?
    
    
    init(dictionary: NSDictionary){
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        retweetCount = dictionary["retweet_count"] as? NSNumber
        favoriteCount = dictionary["favorite_count"] as? NSNumber
        
        
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet]{
        var tweets = [Tweet] ()
        
        for dictionary in array{
            tweets.append(Tweet (dictionary: dictionary))
        }
        return tweets
    }
    
}
