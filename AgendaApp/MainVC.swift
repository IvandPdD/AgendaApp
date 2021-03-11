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
import MaterialComponents
import KeyboardLayoutGuide

class MainVC: UIViewController{
    
    var user: User?
    
    @IBOutlet var collectionView: UICollectionView!
    
    var editable: Bool = false
    var currentCell: Int?
    var section:Int?
    var preSection:Int?
    var expand:Bool = false
    
    var addContactVC: AddContactVC?
    var addButton: MDCFloatingButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        self.addButton = MDCFloatingButton(frame: CGRect(x: 325, y: 800, width: 50, height: 50), shape: .default)
        self.addButton?.setElevation(ShadowElevation(rawValue: 5), for: .normal)
        self.addButton?.backgroundColor = .systemTeal
        self.addButton?.setImage(UIImage(systemName: "plus"), for: .normal)
        self.addButton?.setImageTintColor(.white, for: .normal)
        self.view.addSubview(self.addButton!)
        
        self.addButton?.addTarget(self, action: #selector(self.addContact(sender:)), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(NetworkManager.shared.checkUser()){
            self.user = NetworkManager.shared.getUser()
        }
    }

    @objc func addContact(sender: MDCFloatingButton) {
        
        let transitionDelegate = SPStorkTransitioningDelegate()
        self.addContactVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "addContact") as! AddContactVC
        self.addContactVC!.master = self
        self.addContactVC?.transitioningDelegate = transitionDelegate
        self.addContactVC?.modalPresentationStyle = .custom
        self.addContactVC!.modalPresentationCapturesStatusBarAppearance = true

        transitionDelegate.customHeight = 500
        transitionDelegate.indicatorMode = .alwaysLine
        transitionDelegate.swipeToDismissEnabled = true
        transitionDelegate.translateForDismiss = 10
        transitionDelegate.tapAroundToDismissEnabled = false
        
        present(self.addContactVC!, animated: true, completion: nil)
    }
    
}


extension MainVC: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return UserData.shared.currentUser.contacts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell",
                                                            for: indexPath) as! ContactCell
        cell.photo.image = UIImage(systemName: "person.circle.fill")
        cell.photo.tintColor = .systemTeal
        cell.name.text = UserData.shared.currentUser.contacts[indexPath.row].name
        cell.phoneNumber.text = UserData.shared.currentUser.contacts[indexPath.row].phoneNumber
        cell.editContact.setImage(UIImage(systemName: "pencil"), for: .normal)
        cell.editContact.backgroundColor = .white
        cell.editContact.enableRippleBehavior = true
        cell.deleteContact.enableRippleBehavior = true
        
        cell.editButtonAction = {
            let currentCell = collectionView.cellForItem(at: indexPath) as! ContactCell
            
            self.editable.toggle()
            currentCell.name.isEnabled.toggle()
            currentCell.name.isHighlighted.toggle()
            currentCell.phoneNumber.isEnabled.toggle()
            currentCell.deleteContact.isHidden.toggle()
            
            if (self.editable) {
                currentCell.editContact.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
                currentCell.setShadowElevation(ShadowElevation(rawValue: 8), for: .normal)  
                
            }else{
                //NetworkManager.shared.modifyContact(contactAt: indexPath.row, contact: <#T##Contact#>)
                UserData.shared.currentUser.contacts[indexPath.row].name = currentCell.name.text!
                UserData.shared.currentUser.contacts[indexPath.row].phoneNumber = currentCell.phoneNumber.text!
                NetworkManager.shared.saveUser(user: UserData.shared.currentUser.user, pass: UserData.shared.currentUser.pass, contacts: UserData.shared.currentUser.contacts)
                
                currentCell.editContact.setImage(UIImage(systemName: "pencil"), for: .normal)
                currentCell.setShadowElevation(ShadowElevation(rawValue: 2), for: .normal)
            }
        }
            
        cell.deleteButtonAction = {
            //NetworkManager.shared.deleteContact(contactAt: indexPath.row)
            UserData.shared.currentUser.contacts.remove(at: indexPath.row)
            NetworkManager.shared.saveUser(user: UserData.shared.currentUser.user, pass: UserData.shared.currentUser.pass, contacts: UserData.shared.currentUser.contacts)
            
            let currentCell = collectionView.cellForItem(at: indexPath) as! ContactCell
            self.editable.toggle()
            currentCell.name.isEnabled.toggle()
            currentCell.phoneNumber.isEnabled.toggle()
            currentCell.deleteContact.isHidden.toggle()
            currentCell.editContact.setImage(UIImage(systemName: "pencil"), for: .normal)
            currentCell.setShadowElevation(ShadowElevation(rawValue: 2), for: .normal)
            self.editable = false
            self.collectionView.reloadData()
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if (self.section != nil) {
            self.preSection = self.section
        }

        self.section = indexPath.row

        if self.preSection == self.section {
            self.preSection = nil
            self.section = nil
        }else if (self.preSection != nil) {
            self.expand = false
        }
        self.expand = !self.expand
        self.collectionView.reloadItems(at: collectionView.indexPathsForSelectedItems!)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

            if self.expand, let row = self.section, row == indexPath.row {
                return CGSize(width: self.view.bounds.width - 20, height: 300)
            }else{
                return CGSize(width: self.view.bounds.width - 20, height: 100.0)
            }

        }
    
}
