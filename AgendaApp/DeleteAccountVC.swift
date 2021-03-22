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
        
        let activityIndicator = UIActivityIndicatorView()
        view.addSubview(activityIndicator)
        activityIndicator.center = CGPoint(x: self.view.frame.size.width / 2, y: self.view.frame.size.height / 2)
        activityIndicator.startAnimating()
        
        NetworkManager.shared.deleteUser(completionHandler: {
            success in
            
            if(success){
                
                activityIndicator.stopAnimating()
                self.performSegue(withIdentifier: "DeleteAccountToLogin", sender: Any?.self)
                
            }else{
                activityIndicator.stopAnimating()
                
                var dialogMessage = UIAlertController(title: "Alert", message: "Incorrect data", preferredStyle: .alert)
                dialogMessage.isSpringLoaded = true
                
                let ok = UIAlertAction(title: "OK", style: .default)
                dialogMessage.addAction(ok)
            }
        })
    }
}
