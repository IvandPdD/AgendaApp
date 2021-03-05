//
//  MainVC.swift
//  AgendaApp
//
//  Created by user177578 on 3/5/21.
//  Copyright © 2021 Apps2t. All rights reserved.
//

import Foundation
import UIKit
import SPStorkController

class MainVC: UIViewController{
    
    var addContact: UIViewController?
    var table: UITableView?

    override func viewDidLoad() {
        
    }
    
    
    @IBAction func addContact(_ sender: Any) {
        let transitionDelegate = SPStorkTransitioningDelegate()
        self.addContact = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "addContact")
        self.addContact?.transitioningDelegate = transitionDelegate
        self.addContact?.modalPresentationStyle = .custom
        self.addContact!.modalPresentationCapturesStatusBarAppearance = true
        transitionDelegate.customHeight = 250
        transitionDelegate.indicatorMode = .alwaysLine
        transitionDelegate.swipeToDismissEnabled = true
        transitionDelegate.translateForDismiss = 100
        
        present(self.addContact!, animated: true, completion: nil)
    }
}


extension MainVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return 10
        }
     
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ContactCell
     
            cell.labelCell.text = "Ivan"
            cell.imageCell.image = UIImage(systemName: "person.crop.circle.fill")

            return cell
        }
}
