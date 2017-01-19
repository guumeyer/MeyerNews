//
//  StoriesTableViewController.swift
//  NewDesigner
//
//  Created by gustavo r meyer on 1/17/17.
//  Copyright © 2017 gustavo r meyer. All rights reserved.
//

import UIKit
import SwiftyJSON
import Spring

class StoriesTableViewController: UITableViewController, StoryTableViewCellDelegate, MenuViewControllerDelegate,LoginViewControllerDelegate {

    // MARK: - Variable
    let transitionManager = TransitionManager()
    var stories: JSON! = []
    var isFirstTime = true
    var section = ""
    
    // MARK: - Outlets
    @IBOutlet weak var loginButton: UIBarButtonItem!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        refreshControl?.addTarget(self, action: #selector(self.refreshStories), for: UIControlEvents.valueChanged)
        
        loadStories("", page: 1)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if LocalStore.getToken() == nil {
            loginButton.title = "Login"
            loginButton.isEnabled = true
        } else {
            loginButton.title = ""
            loginButton.isEnabled = false
        }
        
        if isFirstTime {
            view.showLoading()
            isFirstTime = false
        }
    }
    
    // MARK: - Actions
    @IBAction func loginButtonDidTouch(_ sender: Any) {
        performSegue(withIdentifier: "LoginSegue", sender: self)
    }
    
    @IBAction func menuButtonDidTouch(_ sender: Any) {
        performSegue(withIdentifier: "MenuSegue", sender: self)
    }
    
    func refreshStories() {
        loadStories(section, page: 1)
    }
    
    // MARK: - Table View
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoryCell") as! StoryTableViewCell
        let story = stories[indexPath.row]
        let storyId = story["id"].int!
        
        cell.delegate = self
        LocalStore.saveUpvotedStory(storyId)
        cell.configureWithStory(story)
        
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "WebSegue", sender: indexPath)
    }
    
    // MARK: - Navigation
    override func segueForUnwinding(to toViewController: UIViewController, from fromViewController: UIViewController, identifier: String?) -> UIStoryboardSegue {
        let segue = CustomUnwindSegue(identifier: identifier, source: fromViewController, destination: toViewController)
        segue.animationType = .swipeDown
        return segue
    }
    
    // MARK: Misc
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WebSegue" {
            let toView = segue.destination as! WebViewController
            let indexPath = sender as! IndexPath
            //let url = data[indexPath.row]["url"].string!
            let url = stories[indexPath.row]["url"].string!
            toView.url = url
            toView.transitioningDelegate = transitionManager
            
            UIApplication.shared.isStatusBarHidden = true
        }
    
        if segue.identifier == "CommentsSegue" {
            let toView = segue.destination as! CommentsTableViewController
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)!
            //let story = data[indexPath.row]
            let story = stories[indexPath.row]
            toView.story = story
        }
        
        if segue.identifier == "MenuSegue" {
            let toView = segue.destination as! MenuViewController
            toView.delegate = self
        }
        
        if segue.identifier == "LoginSegue" {
            let toView = segue.destination as! LoginViewController
            toView.delegate = self
        }
    }
    
    // MARK: - StoryTableViewCellDelegate
    func storyTableViewCellDidTouchUpvote(_ cell: StoryTableViewCell, sender: AnyObject) {
        if let token = LocalStore.getToken() {
            let indexPath = tableView.indexPath(for: cell)!
            let story = stories[indexPath.row]
            let storyId = story["id"].int!
            DNService.upvoteStoryWithId(storyId, token: token, completion: { (successful) in
                print(successful)
                cell.upVoteButton.setImage(UIImage(named: "icon-upvote-active"), for: .normal)
                cell.upVoteButton.setTitle(String(story["vote_count"].int! + 1), for: .normal)
            })
        } else {
            performSegue(withIdentifier: "LoginSegue", sender: self)
        }
    }
    
    func storyTableViewCellDidTouchComment(_ cell: StoryTableViewCell, sender: AnyObject) {
        performSegue(withIdentifier: "CommentsSegue", sender: cell)
    }
    
    // MARK: - MenuViewControllerDelegate
    func menuViewControllerDidTouchTop(_ controller: MenuViewController) {
        view.showLoading()
        loadStories("", page: 1)
        section = ""
        navigationItem.title = "Top Stories"
    }
    
    func menuViewControllerDidTouchRecent(_ controller: MenuViewController) {
        view.showLoading()
        loadStories("recent", page: 1)
        section = "recent"
        navigationItem.title = "Recent Stories"
    }
    
    func menuViewControllerDidTouchLogout(_ controller: MenuViewController) {
        loadStories(section, page: 1)
        view.showLoading()
    }
    
    // MARK: - LoginViewControllerDelegate
    func loginViewControllerDidLogin(_ controller: LoginViewController) {
        loadStories(section, page: 1)
        view.showLoading()
    }
    
    // MARK: - Functions
    func loadStories(_ section: String, page: Int) {
        DNService.storiesForSection(section, page: page) { (JSON) -> () in
            self.stories = JSON["stories"]
            self.tableView.reloadData()
            
            self.view.hideLoading()
            self.refreshControl?.endRefreshing()
        }
    }
}
