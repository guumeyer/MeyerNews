//
//  StoriesTableViewController.swift
//  NewDesigner
//
//  Created by gustavo r meyer on 1/17/17.
//  Copyright © 2017 gustavo r meyer. All rights reserved.
//

import UIKit

class StoriesTableViewController: UITableViewController {

    // MARK: - Variable
    
    // MARK: - Outlets
    
    // MARK: - Life cycle
    
    // MARK: - Actions
    @IBAction func loginButtonDidTouch(_ sender: Any) {
        performSegue(withIdentifier: "LoginSegue", sender: self)
    }
    
    @IBAction func menuButtonDidTouch(_ sender: Any) {
        performSegue(withIdentifier: "MenuSegue", sender: self)
    }
    
    // MARK: - Table View
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoryCell")! as! StoryTableViewCell
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "WebSegue", sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    // MARK: - Navigation
}
