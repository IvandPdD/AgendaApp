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

class SettingsVC: UIViewController{
    
    @IBOutlet weak var pass: MDCTextField!
    @IBOutlet weak var newPass: MDCTextField!
    
    override func viewDidLoad() {
        
    }
    
    @IBAction func changePass(_ sender: Any) {
        if(pass.hasTextContent && newPass.hasTextContent && pass.text == "test"){
            NetworkManager.shared.editUser(newPass: newPass.text!)
        }
    }
    
    @IBAction func deleteAccount(_ sender: Any) {
        
        //NetworkManager.shared.deleteUser(id: <#Int#>)
    }
    
}
