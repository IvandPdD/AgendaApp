//
//  AddContactVC.swift
//  AgendaApp
//
//  Created by user177578 on 3/7/21.
//  Copyright © 2021 Apps2t. All rights reserved.
//

import Foundation
import UIKit
import MaterialComponents

class AddContactVC: UIViewController{
    
    var master: MainVC?
    
    @IBOutlet weak var addName: MDCTextField!
    @IBOutlet weak var addNumber: MDCTextField!
    
    override func viewDidLoad() {
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func confirmAddContact(_ sender: MDCButton) {
        
        if (addName.hasTextContent && addNumber.hasTextContent) {
                    
            UserData.shared.currentUser.contacts.append(Contact(name: addName.text!, phoneNumber: addNumber.text!))
            NetworkManager.shared.saveUser(user: UserData.shared.currentUser.user, pass: UserData.shared.currentUser.pass, contacts: UserData.shared.currentUser.contacts)
            //NetworkManager.shared.createContact(contact: <#T##Contact#>)
            
            self.dismiss(animated: true, completion: {
                self.master?.collectionView.reloadData()
            })
        }else{
            var dialogMessage = UIAlertController(title: "Alert", message: "Empty Fields", preferredStyle: .actionSheet)
            dialogMessage.isSpringLoaded = true
            
            let ok = UIAlertAction(title: "OK", style: .default)
            dialogMessage.addAction(ok)
            
            self.present(dialogMessage, animated: true, completion: nil)
        }
    }
}
