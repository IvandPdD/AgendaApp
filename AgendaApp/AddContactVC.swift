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
        
        let activityIndicator = UIActivityIndicatorView()
        view.addSubview(activityIndicator)
        activityIndicator.center = CGPoint(x: self.view.frame.size.width / 2, y: self.view.frame.size.height / 2)
        activityIndicator.startAnimating()
        
        if (addName.hasTextContent && addNumber.hasTextContent && addEmail.hasTextContent) {
                    
            NetworkManager.shared.createContact(contact_name: addName.text!, contact_email: addEmail.text!, contact_phone: addNumber.text!, completionHandler: {
                success in
                
                if(success){
                    activityIndicator.stopAnimating()
                    
                    NetworkManager.shared.getContacts(completionHandler: {
                        contacts in
            
                        self.dismiss(animated: true, completion:{
                            UserData.shared.contacts = contacts
                            self.master?.collectionView.reloadData()
                        })
            
                    })
                    
                    
                }else{
                    activityIndicator.stopAnimating()
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
}
