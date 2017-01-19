//
//  CommentsTableViewTableViewCell.swift
//  NewDesigner
//
//  Created by gustavo r meyer on 1/18/17.
//  Copyright © 2017 gustavo r meyer. All rights reserved.
//

import UIKit
import Spring
import SwiftyJSON

class CommentsTableViewCell: UITableViewCell {

    // MARK: - Variable
    weak var delegate: CommentTableViewCellDelegate?
    
    // MARK: - Outlets
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var upvoteButton: SpringButton!
    @IBOutlet weak var replyButton: SpringButton!
    @IBOutlet weak var commentTextView: AutoTextView!
    
    // MARK: - Life cycle
    
    // MARK: - Actions
    @IBAction func upvoteButtonDidTouch(_ sender: AnyObject) {
        upvoteButton.animation = "pop"
        upvoteButton.force = 3
        upvoteButton.animateNext {
            self.delegate?.commentTableViewCellDidTouchUpvote(self)
        }
    }
    
    @IBAction func replyButtonDidTouch(_ sender: AnyObject) {
        
        replyButton.animation = "pop"
        replyButton.force = 3
        replyButton.animateNext{
            self.delegate?.commentTableViewCellDidTouchComment(self)
        }
    }
    
    func configureWithComment(_ comment: JSON) {
        
        //let userPortraitUrl = comment["user_portrait_url"].string!
        let userDisplayName = comment["user_display_name"].string!
        
        let userPortraitUrl = comment["user_portrait_url"].string ?? ""
        let userJob = comment["user_job"].string ?? ""
        
        //let userJob = comment["user_job"].string!
        let createdAt = comment["created_at"].string!
        let voteCount = comment["vote_count"].int!
        let body = comment["body"].string!
        //let bodyHTML = comment["body_html"].string ?? ""
        
        avatarImageView.image = UIImage(named: "content-avatar-default")
        //avatarImageView.setImage(link: userPortraitUrl, placeholderImage: UIImage(named: "content-avatar-default"))
        
        authorLabel.text = userDisplayName + ", " + userJob
        timeLabel.text = timeAgoSinceDate(date: dateFromString(date: createdAt, format: "yyyy-MM-dd'T'HH:mm:ssZ"), numericDates: true)
        //upvoteButton.setTitle(String(voteCount), for: UIControlState.normal)
        replyButton.setTitle("", for: UIControlState.normal)
        commentTextView.text = body
        //commentTextView.attributedText = htmlToAttributedString(text: bodyHTML + "<style>*{font-family:\"Avenir Next\";font-size:16px;line-height:20px}img{max-width:300px}</style>")
        
        let commentId = comment["id"].int!
        if LocalStore.isCommentUpvoted(commentId) {
            upvoteButton.setImage(UIImage(named: "icon-upvote-active"), for: .normal)
            upvoteButton.setTitle(String(voteCount+1), for: .normal)
        } else {
            upvoteButton.setImage(UIImage(named: "icon-upvote"), for: .normal)
            upvoteButton.setTitle(String(voteCount), for: .normal)
        }
        
    }
    // MARK: - Navigation
    
    
    
    
}
