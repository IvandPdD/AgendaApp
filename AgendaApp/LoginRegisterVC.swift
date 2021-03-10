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
    @IBOutlet weak var userRegister: MDCTextField!
    @IBOutlet weak var passRegister: MDCTextField!
    @IBOutlet weak var confirmPassRegister: MDCTextField!
    
    
    override func viewDidLoad() {
        
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func login(_ sender: MDCRaisedButton) {
        if(userLogin.hasTextContent && passLogin.hasTextContent){
            NetworkManager.shared.getUser(user: userLogin.text!, pass: passLogin.text!)
            self.performSegue(withIdentifier: "LoginSegue", sender: Any?.self)
        }
    }
    
    @IBAction func register(_ sender: MDCRaisedButton) {
        if(userRegister.hasTextContent && passRegister.hasTextContent && confirmPassRegister.hasTextContent && passRegister.text == confirmPassRegister.text){
            NetworkManager.shared.createUser(user: userRegister.text!, pass: passRegister.text!)
            self.performSegue(withIdentifier: "RegisterSegue", sender: Any?.self)
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
