//
//  ChangePassVC.swift
//  AgendaApp
//
//  Created by user177578 on 3/21/21.
//  Copyright © 2021 Apps2t. All rights reserved.
//

import Foundation
import UIKit
import MaterialComponents

class ChangePassVC: UIViewController{
    
    @IBOutlet weak var newPass: MDCTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func changePass(_ sender: Any) {
        
        self.showSpinner(onView: self.view)
        
        NetworkManager.shared.changePass(newPass: newPass.text!, completion: {
            success in
            
            if(!success){
                self.removeSpinner()
                
                var dialogMessage = UIAlertController(title: "Alert", message: "No se ha podido cambiar la contraseña", preferredStyle: .alert)
                dialogMessage.isSpringLoaded = true
                
                let ok = UIAlertAction(title: "OK", style: .default)
                dialogMessage.addAction(ok)
                
                self.present(dialogMessage, animated: true, completion: nil)
            }
        })
    }
}
