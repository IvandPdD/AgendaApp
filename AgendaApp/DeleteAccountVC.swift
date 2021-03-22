//
//  DeleteAccountVC.swift
//  AgendaApp
//
//  Created by user177578 on 3/21/21.
//  Copyright © 2021 Apps2t. All rights reserved.
//

import Foundation
import UIKit

class DeleteAccountVC: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func deleteAccount(_ sender: Any) {
        
        self.showSpinner(onView: self.view)
        
        NetworkManager.shared.deleteUser(completion: {
            success in
            
            if(success){
                
                self.removeSpinner()
                self.performSegue(withIdentifier: "DeleteAccountToLogin", sender: Any?.self)
                
            }else{
                self.removeSpinner()
                
                var dialogMessage = UIAlertController(title: "Alert", message: "Incorrect data", preferredStyle: .alert)
                dialogMessage.isSpringLoaded = true
                
                let ok = UIAlertAction(title: "OK", style: .default)
                dialogMessage.addAction(ok)
            }
        })
    }
}
