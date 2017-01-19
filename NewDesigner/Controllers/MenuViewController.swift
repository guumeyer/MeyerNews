//
//  MenuViewController.swift
//  NewDesigner
//
//  Created by gustavo r meyer on 1/17/17.
//  Copyright © 2017 gustavo r meyer. All rights reserved.
//

import UIKit
import Spring

class MenuViewController: UIViewController {

    // MARK: - Variable
    weak var delegate: MenuViewControllerDelegate?
    
    // MARK: - Outlets
    @IBOutlet weak var dialogView: DesignableView!
    @IBOutlet weak var loginLabel: UILabel!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if LocalStore.getToken() == nil {
            loginLabel.text = "Login"
        } else {
            loginLabel.text = "Logout"
        }
    }
    
    // MARK: - Actions
    @IBAction func closeButtonDidTouch(_ sender: Any) {
        
        dialogView.animation = "zoomOut"
        dialogView.animateNext {
            self.dismiss(animated: true, completion: nil)
        }
    }
    @IBAction func topButtonDidTouch(_ sender: AnyObject) {
        delegate?.menuViewControllerDidTouchTop(self)
        closeButtonDidTouch(sender)
    }
    
    @IBAction func recentButtonDidTouch(_ sender: AnyObject) {
        delegate?.menuViewControllerDidTouchRecent(self)
        closeButtonDidTouch(sender)
    }
    
    @IBAction func loginButtonDidTouch(_ sender: AnyObject) {
        if LocalStore.getToken() == nil {
            performSegue(withIdentifier: "LoginSegue", sender: self)
        } else {
            LocalStore.deleteToken()
            closeButtonDidTouch(sender)
            delegate?.menuViewControllerDidTouchLogout(self)
        }
    }
    
    // MARK: - Navigation
}
