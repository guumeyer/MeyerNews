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
    
    // MARK: - Outlets
    @IBOutlet weak var dialogView: DesignableView!
    
    // MARK: - Life cycle
    
    // MARK: - Actions
    @IBAction func closeButtonDidTouch(_ sender: Any) {
        dialogView.animation = "zoomOut"
        dialogView.animateNext {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    // MARK: - Navigation
}
