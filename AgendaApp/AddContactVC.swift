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
    
    @IBOutlet weak var addName: UITextField!
    @IBOutlet weak var addNumber: UITextField!
    
    @IBAction func confirmAddContact(_ sender: MDCButton) {
        
        master!.contactName.append(addName.text!)
        master!.contactNumber.append(addNumber.text!)
//        contactName.append(self.addName.text!)
//        contactNumber.append(self.addNumber.text!)
        self.dismiss(animated: true, completion: {
            self.master?.collectionView.reloadData()
        })
//        self.collectionView.reloadData()
    }
}
