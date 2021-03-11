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
            if(NetworkManager.shared.checkUser()){
                
                UserData.shared.currentUser = NetworkManager.shared.getUser()
                
                if(UserData.shared.currentUser.user == userLogin.text && UserData.shared.currentUser.pass == passLogin.text){
                    
                    self.performSegue(withIdentifier: "LoginToMain", sender: Any?.self)
                }
            }
//            NetworkManager.shared.getUser(user: userLogin.text!, pass: passLogin.text!)
//            self.performSegue(withIdentifier: "LoginToMain", sender: Any?.self)
        }else{
            var dialogMessage = UIAlertController(title: "Alert", message: "Empty Fields", preferredStyle: .actionSheet)
            dialogMessage.isSpringLoaded = true
            
            let ok = UIAlertAction(title: "OK", style: .default)
            dialogMessage.addAction(ok)
            
            self.present(dialogMessage, animated: true, completion: nil)
        }
    }
    
    @IBAction func register(_ sender: MDCRaisedButton) {
        
        if(userRegister.hasTextContent && passRegister.hasTextContent && confirmPassRegister.hasTextContent && passRegister.text == confirmPassRegister.text){
            
            var contactList: [Contact] = []
            
            NetworkManager.shared.saveUser(user: userRegister.text!, pass: passRegister.text!, contacts: contactList)
            self.performSegue(withIdentifier: "RegisterToLogin", sender: Any?.self)
            
//            NetworkManager.shared.createUser(user: userRegister.text!, pass: passRegister.text!)
//            self.performSegue(withIdentifier: "RegisterToLogin", sender: Any?.self)
        }else{
            var dialogMessage = UIAlertController(title: "Alert", message: "Empty Fields", preferredStyle: .actionSheet)
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
