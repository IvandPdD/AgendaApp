//
//  LoginRegisterVC.swift
//  AgendaApp
//
//  Created by Apps2t on 04/03/2021.
//  Copyright © 2021 Apps2t. All rights reserved.
//

import Foundation
import UIKit
import MaterialComponents

class LoginRegisterVC: UIViewController{
    
    @IBOutlet weak var userLogin: MDCTextField!
    @IBOutlet weak var passLogin: MDCTextField!
    @IBOutlet weak var emailRegister: MDCTextField!
    @IBOutlet weak var userRegister: MDCTextField!
    @IBOutlet weak var passRegister: MDCTextField!
    @IBOutlet weak var confirmPassRegister: MDCTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func login(_ sender: MDCRaisedButton) {
        
        let activityIndicator = UIActivityIndicatorView()
        view.addSubview(activityIndicator)
        activityIndicator.center = CGPoint(x: self.view.frame.size.width / 2, y: self.view.frame.size.height / 2)
        activityIndicator.startAnimating()
        
        
        if(userLogin.hasTextContent && passLogin.hasTextContent){

            NetworkManager.shared.loginUser(email: userLogin.text!, password: passLogin.text!, completionHandler: {
                success in
                if(success){
                    activityIndicator.stopAnimating()
                    self.performSegue(withIdentifier: "LoginToMain", sender: Any?.self)
                    
                }else{
                    activityIndicator.stopAnimating()
                    
                    var dialogMessage = UIAlertController(title: "Alert", message: "Incorrect data", preferredStyle: .alert)
                    dialogMessage.isSpringLoaded = true
                    
                    let ok = UIAlertAction(title: "OK", style: .default)
                    dialogMessage.addAction(ok)
                    
                    self.present(dialogMessage, animated: true, completion: nil)
                }
            })

        }else{
            activityIndicator.stopAnimating()
            
            var dialogMessage = UIAlertController(title: "Alert", message: "Empty Fields", preferredStyle: .actionSheet)
            dialogMessage.isSpringLoaded = true
            
            let ok = UIAlertAction(title: "OK", style: .default)
            dialogMessage.addAction(ok)
            
            self.present(dialogMessage, animated: true, completion: nil)
        }
    }
    
    @IBAction func register(_ sender: MDCRaisedButton) {
        
        let activityIndicator = UIActivityIndicatorView()
        view.addSubview(activityIndicator)
        activityIndicator.center = CGPoint(x: self.view.frame.size.width / 2, y: self.view.frame.size.height / 2)
        activityIndicator.startAnimating()
        
        if(userRegister.hasTextContent && passRegister.hasTextContent && confirmPassRegister.hasTextContent && passRegister.text == confirmPassRegister.text){
            
            NetworkManager.shared.createUser(name: userRegister.text!, email: emailRegister.text!, pass: passRegister.text!, confirmPass: confirmPassRegister.text!, completion: {
                success in
                
                if (success){
                    activityIndicator.stopAnimating()
                    self.performSegue(withIdentifier: "RegisterToLogin", sender: Any?.self)
                }else{
                    activityIndicator.stopAnimating()
                    
                    var dialogMessage = UIAlertController(title: "Alert", message: "Empty Fields", preferredStyle: .alert)
                    dialogMessage.isSpringLoaded = true
                    
                    let ok = UIAlertAction(title: "OK", style: .default)
                    dialogMessage.addAction(ok)
                    
                    self.present(dialogMessage, animated: true, completion: nil)
                }
                
            })
        }else{
            activityIndicator.stopAnimating()
            var dialogMessage = UIAlertController(title: "Alert", message: "Incorrect data", preferredStyle: .actionSheet)
            dialogMessage.isSpringLoaded = true
            
            let ok = UIAlertAction(title: "OK", style: .default)
            dialogMessage.addAction(ok)
            
            self.present(dialogMessage, animated: true, completion: nil)
        }
        
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
