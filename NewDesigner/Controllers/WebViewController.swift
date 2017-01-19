//
//  WebViewController.swift
//  NewDesigner
//
//  Created by gustavo r meyer on 1/17/17.
//  Copyright © 2017 gustavo r meyer. All rights reserved.
//

import UIKit
import Spring

class WebViewController: UIViewController,UIWebViewDelegate {

    // MARK: - Variable
    var url: String!
    var hasFinishedLoading = false
    
    // MARK: - Outlets
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var progressView: UIProgressView!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.delegate = self
        
        let targetURL = URL(string: url)
        let request = URLRequest(url: targetURL!)
        webView.loadRequest(request)
    }
    
    // MARK: - Actions

    @IBAction func closeButtonDidTouch(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        UIApplication.shared.isStatusBarHidden = false
    }
    
    @IBAction func shareButtonDidTouch(_ sender: Any) {
        
    }
  
    // MARK: - Navigation
    
    // MARK: - UIWebViewDelegate
    func webViewDidStartLoad(_ webView: UIWebView) {
        hasFinishedLoading = false
        updateProgress()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        delay(delay: 1) { [weak self] in
            if let _self = self {
                _self.hasFinishedLoading = true
            }
        }
    }
    
    deinit {
        webView.stopLoading()
        webView.delegate = nil
    }
    
    func updateProgress() {
        if progressView.progress >= 1 {
            progressView.isHidden = true
        } else {
            
            if hasFinishedLoading {
                progressView.progress += 0.002
            } else {
                if progressView.progress <= 0.3 {
                    progressView.progress += 0.004
                } else if progressView.progress <= 0.6 {
                    progressView.progress += 0.002
                } else if progressView.progress <= 0.9 {
                    progressView.progress += 0.001
                } else if progressView.progress <= 0.94 {
                    progressView.progress += 0.0001
                } else {
                    progressView.progress = 0.9401
                }
            }
            
            delay(delay: 0.008) { [weak self] in
                if let _self = self {
                    _self.updateProgress()
                }
            }
        }
    }
    
}
