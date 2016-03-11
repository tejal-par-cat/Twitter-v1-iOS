//
//  TweetCell.swift
//  TwitterApp
//
//  Created by Tejal Par on 9/29/14.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var timestampLabel: UILabel!
    @IBOutlet var tweetLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
