//
//  LoginViewController.swift
//  NewDesigner
//
//  Created by gustavo r meyer on 1/17/17.
//  Copyright © 2017 gustavo r meyer. All rights reserved.
//

import UIKit
import Spring

class LoginViewController: UIViewController {

    // MARK: - Variable
    
    
    // MARK: - Outlets
    @IBOutlet weak var dialogView: DesignableView!
    
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Actions
    @IBAction func loginButtonDidTouch(_ sender: Any) {
        dialogView.animation = "shake"
        dialogView.animate()
    }
    
    
    // MARK: - Navigation

}
