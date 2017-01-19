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
        bookImageView.animateNext {
            self.openURL("http://designcode.io")
        }
    }
    @IBAction func twitterButtonDidTouch(_ sender: AnyObject) {
        openURL("http://twitter.com/guumeyer")
    }
    
    @IBAction func closeButtonDidToach(_ sender: Any) {
        dialogView.animation = "fall"
        dialogView.animateNext {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: - Functions
    func openURL(_ url: String) {
        let targetURL = URL(string: url)
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(targetURL!, options: [String:Any](), completionHandler: nil)
        } else {
            UIApplication.shared.openURL(targetURL!)

        }
    }
    

}
