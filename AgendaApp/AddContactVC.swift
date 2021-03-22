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
    @IBOutlet weak var addEmail: MDCTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func confirmAddContact(_ sender: MDCButton) {
        
        self.showSpinner(onView: self.view)
        
        if (addName.hasTextContent && addNumber.hasTextContent && addEmail.hasTextContent) {
                    
            NetworkManager.shared.createContact(name: addName.text!, email: addEmail.text!, phoneNumber: addNumber.text!, completion: {
                success in
                
                if(success){
                    self.removeSpinner()
                    
                    NetworkManager.shared.getContacts(completion: {
                        contacts in
            
                        self.dismiss(animated: true, completion:{
                            UserData.shared.contacts = contacts
                            self.master?.collectionView.reloadData()
                        })
            
                    })
                    
                    
                }else{
                    self.removeSpinner()
                }
                
            })
        }else{
            self.removeSpinner()
            
            var dialogMessage = UIAlertController(title: "Alert", message: "Empty Fields", preferredStyle: .actionSheet)
            dialogMessage.isSpringLoaded = true
            
            let ok = UIAlertAction(title: "OK", style: .default)
            dialogMessage.addAction(ok)
            
            self.present(dialogMessage, animated: true, completion: nil)
        }
    }
}
