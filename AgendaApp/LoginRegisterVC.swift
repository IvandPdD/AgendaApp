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
        
        self.showSpinner(onView: self.view)
        
        if(userLogin.hasTextContent && passLogin.hasTextContent){

            NetworkManager.shared.loginUser(email: userLogin.text!, pass: passLogin.text!, completion: {
                success in
                if(success){
                    self.removeSpinner()
                    self.performSegue(withIdentifier: "LoginToMain", sender: Any?.self)
                    
                }else{
                    self.removeSpinner()
                    var dialogMessage = UIAlertController(title: "Alert", message: "Incorrect data", preferredStyle: .alert)
                    dialogMessage.isSpringLoaded = true
                    
                    let ok = UIAlertAction(title: "OK", style: .default)
                    dialogMessage.addAction(ok)
                    
                    self.present(dialogMessage, animated: true, completion: nil)
                }
            })

        }else{
            
            var dialogMessage = UIAlertController(title: "Alert", message: "Empty Fields", preferredStyle: .actionSheet)
            dialogMessage.isSpringLoaded = true
            
            let ok = UIAlertAction(title: "OK", style: .default)
            dialogMessage.addAction(ok)
            
            self.present(dialogMessage, animated: true, completion: nil)
        }
    }
    
    @IBAction func register(_ sender: MDCRaisedButton) {
        
        self.showSpinner(onView: self.view)
        
        if(userRegister.hasTextContent && passRegister.hasTextContent && confirmPassRegister.hasTextContent && passRegister.text == confirmPassRegister.text){
            
            NetworkManager.shared.createUser(name: userRegister.text!, email: emailRegister.text!, pass: passRegister.text!, confirmPass: confirmPassRegister.text!, completion: {
                success in
                
                if (success){
                    self.removeSpinner()
                    self.performSegue(withIdentifier: "RegisterToLogin", sender: Any?.self)
                }else{
                    self.removeSpinner()
                    
                    var dialogMessage = UIAlertController(title: "Alert", message: "Empty Fields", preferredStyle: .alert)
                    dialogMessage.isSpringLoaded = true
                    
                    let ok = UIAlertAction(title: "OK", style: .default)
                    dialogMessage.addAction(ok)
                    
                    self.present(dialogMessage, animated: true, completion: nil)
                }
                
            })
        }else{
            self.removeSpinner()
            
            var dialogMessage = UIAlertController(title: "Alert", message: "Incorrect data", preferredStyle: .actionSheet)
            dialogMessage.isSpringLoaded = true
            
            let ok = UIAlertAction(title: "OK", style: .default)
            dialogMessage.addAction(ok)
            
            self.present(dialogMessage, animated: true, completion: nil)
        }
        
    }
}

var vSpinner : UIView?

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func showSpinner(onView : UIView) {
            let spinnerView = UIView.init(frame: onView.bounds)
            spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
            let ai = UIActivityIndicatorView.init(style: .whiteLarge)
            ai.startAnimating()
            ai.center = spinnerView.center
            
            DispatchQueue.main.async {
                spinnerView.addSubview(ai)
                onView.addSubview(spinnerView)
            }
            
            vSpinner = spinnerView
        }
        
        func removeSpinner() {
            DispatchQueue.main.async {
                vSpinner?.removeFromSuperview()
                vSpinner = nil
            }
        }
}
