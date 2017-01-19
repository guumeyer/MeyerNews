//
//  LoginViewController.swift
//  NewDesigner
//
//  Created by gustavo r meyer on 1/17/17.
//  Copyright © 2017 gustavo r meyer. All rights reserved.
//

import UIKit
import Spring

class LoginViewController: UIViewController,UITextFieldDelegate {

    // MARK: - Variable
    weak var delegate: LoginViewControllerDelegate?
    
    // MARK: - Outlets
    @IBOutlet weak var dialogView: DesignableView!
    @IBOutlet weak var emailTextField: DesignableTextField!
    @IBOutlet weak var passwordTextField: DesignableTextField!
    @IBOutlet weak var emailImageView: SpringImageView!
    @IBOutlet weak var passwordImageView: SpringImageView!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: - Actions
    @IBAction func loginButtonDidTouch(_ sender: AnyObject) {
        DNService.loginWithEmail(emailTextField.text!, password: passwordTextField.text!) { (token) -> () in
            if let token = token {
                LocalStore.saveToken(token)
                self.delegate?.loginViewControllerDidLogin(self)
                self.dismiss(animated: true, completion: nil)
            } else {
                self.dialogView.animation = "shake"
                self.dialogView.animate()
            }
        }
    }
    
    @IBAction func closeButtonDidTouch(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - UITextFieldDelegate
    //This one is used as the field is active.
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == emailTextField {
            emailImageView.image = UIImage(named: "icon-mail-active")
            emailImageView.animate()
        } else {
            emailImageView.image = UIImage(named: "icon-mail")
        }
        
        if textField == passwordTextField {
            passwordImageView.image = UIImage(named: "icon-password-active")
            passwordImageView.animate()
        } else {
            passwordImageView.image = UIImage(named: "icon-password")
        }
    }
    
    //This function is triggered when the Text Field is no longer active.
    func textFieldDidEndEditing(_ textField: UITextField) {
        emailImageView.image = UIImage(named: "icon-mail")
        passwordImageView.image = UIImage(named: "icon-password")
    }
    
    // MARK: - Funtions
    
    

}
