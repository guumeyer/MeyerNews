//
//  LearnViewController.swift
//  NewDesigner
//
//  Created by gustavo r meyer on 1/17/17.
//  Copyright © 2017 gustavo r meyer. All rights reserved.
//

import UIKit
import Spring

class LearnViewController: UIViewController {

    
    // MARK: - Variable
    
    
    // MARK: - Outlets
    @IBOutlet weak var dialogView: DesignableView!
    @IBOutlet weak var bookImageView: SpringImageView!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //viewWillAppear run faster then viewDidAppear
        dialogView.animate()
    }
    
    // MARK: - Actions
    @IBAction func learnButtonDidTouch(_ sender: Any) {
        bookImageView.animation = "pop"
        bookImageView.animate()
    }
    
    @IBAction func closeButtonDidToach(_ sender: Any) {
        dialogView.animation = "fall"
        dialogView.animateNext {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: - Navigation
    

}
