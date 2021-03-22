//
//  ForgotPassVC.swift
//  AgendaApp
//
//  Created by user177578 on 3/21/21.
//  Copyright © 2021 Apps2t. All rights reserved.
//

import Foundation
import UIKit

class ForgotPassVC: UIViewController{
    
    @IBOutlet weak var email: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func submit(_ sender: Any) {
        
        self.showSpinner(onView: self.view)
        
        NetworkManager.shared.forgotPass(email: email.text!, completion: {
            success in
            
            if(success){
                self.removeSpinner()
                
                var dialogMessage = UIAlertController(title: "Alert", message: "Email correctly sent", preferredStyle: .actionSheet)
                dialogMessage.isSpringLoaded = true
                
                let ok = UIAlertAction(title: "OK", style: .default)
                dialogMessage.addAction(ok)
            }else{
                self.removeSpinner()
            }
        })
    }
}
