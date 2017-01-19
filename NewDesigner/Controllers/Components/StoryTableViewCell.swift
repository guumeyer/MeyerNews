//
//  StoryTableViewCell.swift
//  NewDesigner
//
//  Created by gustavo r meyer on 1/17/17.
//  Copyright © 2017 gustavo r meyer. All rights reserved.
//

import UIKit
import Spring
import SwiftyJSON

class StoryTableViewCell: UITableViewCell {

    
    // MARK: - Variable
    weak var delegate: StoryTableViewCellDelegate?
    
    // MARK: - Outlets
    @IBOutlet weak var badgeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var upVoteButton: SpringButton!
    @IBOutlet weak var commentsButton: SpringButton!
    
    @IBOutlet weak var commentTextView: UITextView!

    
    // MARK: - Life cycle
    
    // MARK: - Functions
    func configureWithStory(_ story: JSON) {
        let title = story["title"].string!
        let badge = story["badge"].string ?? ""
        // let userPortraitUrl = story["user_portrait_url"] as! String
        //let userPortraitUrl = story["user_portrait_url"].string ?? ""
        let userJob = story["user_job"].string ?? ""
        
        let userDisplayName = story["user_display_name"].string!
        let createdAt = story["created_at"].string ?? ""
        let voteCount = story["vote_count"].int!
        let commentCount = story["comment_count"].int!
       
        //let commentHTML = story["comment_html"].string ?? ""

        titleLabel.text = title
        avatarImageView.image = UIImage(named: "content-avatar-default")
        //avatarImageView.setImage(link: userPortraitUrl, placeholderImage: UIImage(named: "content-avatar-default"))
        authorLabel.text = userDisplayName + ", " + userJob
        timeLabel.text = timeAgoSinceDate(date: dateFromString(date: createdAt, format: "yyyy-MM-dd'T'HH:mm:ssZ"), numericDates: true)
        
        //upVoteButton.setTitle(String(voteCount), for: UIControlState.normal)
        commentsButton.setTitle(String(describing: commentCount), for: UIControlState.normal)
        
        badgeImageView.image = UIImage(named: badge)
        
        if let commentTextView = commentTextView {
             let comment = story["comment"].string ?? ""
            commentTextView.text = comment
            //commentTextView.attributedText = htmlToAttributedString(text: commentHTML + "<style>*{font-family:\"Avenir Next\";font-size:16px;line-height:20px}img{max-width:300px}</style>")
            commentTextView.contentInset = UIEdgeInsetsMake(-4, -4, -4, -4)
            layoutIfNeeded()
        }
        
        let storyId = story["id"].int!
        if LocalStore.isStoryUpvoted(storyId) {
            upVoteButton.setImage(UIImage(named: "icon-upvote-active"), for: .normal)
            upVoteButton.setTitle(String(voteCount + 1), for: .normal)
        } else {
            upVoteButton.setImage(UIImage(named: "icon-upvote"), for: .normal)
            upVoteButton.setTitle(String(voteCount), for: .normal)
        }
    }
    
    // MARK: - Actions
    @IBAction func upVoteButtonDidTouch(_ sender: AnyObject) {
        upVoteButton.animation = "pop"
        upVoteButton.force = 3
        upVoteButton.animateNext {
            self.delegate?.storyTableViewCellDidTouchUpvote(self, sender: sender)
        }
    }
    
    @IBAction func commentButtonDidTouch(_ sender: AnyObject) {
        commentsButton.animation = "pop"
        commentsButton.force = 3
        commentsButton.animateNext {
            self.delegate?.storyTableViewCellDidTouchComment(self, sender: sender)
        }
    }   
   

}
