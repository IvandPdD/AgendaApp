//
//  ChangePasswordVC.swift
//  AgendaApp
//
//  Created by Apps2t on 08/03/2021.
//  Copyright © 2021 Apps2t. All rights reserved.
//

import Foundation
import UIKit
import MaterialComponents
import Toaster

class SettingsVC: UIViewController,MDCSnackbarManagerDelegate{
    func willPresentSnackbar(with messageView: MDCSnackbarMessageView) {
        let message = MDCSnackbarMessage()
        message.text = "The groundhog (Marmota monax) is also known as a woodchuck or whistlepig."
    }
    
    
    @IBOutlet weak var pass: MDCTextField!
    @IBOutlet weak var newPass: MDCTextField!
    
    override func viewDidLoad() {
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func changePass(_ sender: Any) {
        if(pass.hasTextContent && newPass.hasTextContent && pass.text == UserData.shared.currentUser.pass){
            //NetworkManager.shared.editUser(newPass: newPass.text!)
            UserData.shared.currentUser.pass = newPass.text!
            NetworkManager.shared.saveUser(user: UserData.shared.currentUser.user, pass: UserData.shared.currentUser.pass, contacts: UserData.shared.currentUser.contacts)
            Toast(text: "Password correctly changed", delay: 0, duration: 5).show()
        }
    }
    
    @IBAction func deleteAccount(_ sender: Any) {
        
        //NetworkManager.shared.deleteUser(id: <#Int#>)
        NetworkManager.shared.defaults.removeObject(forKey: "user")
        self.performSegue(withIdentifier: "DeleteAccountToLogin", sender: Any?.self)
        
    }
    
}
