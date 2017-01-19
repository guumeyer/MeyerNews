//
//  CommentsTableViewController.swift
//  NewDesigner
//
//  Created by gustavo r meyer on 1/17/17.
//  Copyright © 2017 gustavo r meyer. All rights reserved.
//

import UIKit
import SwiftyJSON

class CommentsTableViewController: UITableViewController, CommentTableViewCellDelegate, StoryTableViewCellDelegate {

    // MARK: - Variable
    var button: HamburgerButton! = nil
    var story: JSON!
    var comments: JSON!
    
    // MARK: - Outlets
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //addHamburgerButton()
        
        comments = story["comments"]
    }
    
    
    // MARK: - Actions
    func hamburgerButtonDidTouch(_ sender: AnyObject!) {
        self.dismiss(animated: true, completion: nil)
    }
    // MARK: - Functions
    func addHamburgerButton(){
        //self.view.backgroundColor = UIColor(red: 38.0 / 255, green: 151.0 / 255, blue: 68.0 / 255, alpha: 1)
        
        self.button = HamburgerButton(frame: CGRect(x: 16, y: 28, width: 40, height: 40))
        self.button.addTarget(self, action: #selector(CommentsTableViewController.hamburgerButtonDidTouch(_:)), for:.touchUpInside)
        
        //self.view.addSubview(button)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ReplySegue" {
            let toView = segue.destination as! ReplyViewController
            if let cell = sender as? CommentsTableViewCell {
                let indexPath = tableView.indexPath(for: cell)!
                let comment = comments[indexPath.row - 1]
                toView.comment = comment
            }
            
            if (sender as? StoryTableViewCell) != nil {
                toView.story = story
            }
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = indexPath.row == 0 ? "StoryCell" : "CommentCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as UITableViewCell!
        
        if let storyCell = cell as? StoryTableViewCell {
            storyCell.delegate = self
            storyCell.configureWithStory(story)
        }
        
        if let commentCell = cell as? CommentsTableViewCell {
            let comment = comments[indexPath.row-1]
            commentCell.delegate = self
            commentCell.configureWithComment(comment)
            
        }
        
        return cell!
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count + 1
    }
    
    // MARK: - CommentTableViewCellDelegate
    
    func commentTableViewCellDidTouchUpvote(_ cell: CommentsTableViewCell) {
        if let token = LocalStore.getToken() {
            let indexPath = tableView.indexPath(for: cell)!
            let comment = comments[indexPath.row - 1]
            let commentId = comment["id"].int!
            DNService.upvoteCommentWithId(commentId, token: token, completion: { (successful) in
                
            })
            LocalStore.saveUpvotedComment(commentId)
            cell.configureWithComment(comment)
        } else {
            performSegue(withIdentifier: "LoginSegue", sender: self)
        }
        
    }
    
    func commentTableViewCellDidTouchComment(_ cell: CommentsTableViewCell) {
        if LocalStore.getToken() == nil {
            performSegue(withIdentifier: "LoginSegue", sender: self)
        } else {
            performSegue(withIdentifier: "ReplySegue", sender: cell)
        }
    }
    
    // MARK: - StoryTableViewCellDelegate
    
    func storyTableViewCellDidTouchUpvote(_ cell: StoryTableViewCell, sender: AnyObject) {
        if let token = LocalStore.getToken() {
            // let indexPath = tableView.indexPath(for: cell)!
            let storyId = story["id"].int!
            DNService.upvoteStoryWithId(storyId, token: token, completion: { (successful) in
                
            })
            LocalStore.saveUpvotedStory(storyId)
            cell.configureWithStory(story)
        } else {
            performSegue(withIdentifier: "LoginSegue", sender: self)
        }
    }
    
    func storyTableViewCellDidTouchComment(_ cell: StoryTableViewCell, sender: AnyObject) {
        if LocalStore.getToken() == nil {
            performSegue(withIdentifier: "LoginSegue", sender: self)
        } else {
            performSegue(withIdentifier: "ReplySegue", sender: cell)
        }
    }
    
}
