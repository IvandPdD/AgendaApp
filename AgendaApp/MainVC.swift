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
        
        NetworkManager.shared.getContacts(completionHandler: {
            contact in
            
            if (contact != nil){
                
                UserData.shared.contacts = contact
                self.collectionView.reloadData()
            }
            
        })
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
        return UserData.shared.contacts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell",
                                                            for: indexPath) as! ContactCell
        cell.photo.image = UIImage(systemName: "person.circle.fill")
        cell.photo.tintColor = .systemTeal
        cell.name.text = UserData.shared.contacts[indexPath.row].name
        cell.phoneNumber.text = String(UserData.shared.contacts[indexPath.row].phoneNumber)
        cell.email.text = UserData.shared.contacts[indexPath.row].email
        cell.editContact.setImage(UIImage(systemName: "pencil"), for: .normal)
        cell.editContact.backgroundColor = .white
        cell.editContact.enableRippleBehavior = true
        cell.deleteContact.enableRippleBehavior = true
        
        cell.editButtonAction = {
            let currentCell = collectionView.cellForItem(at: indexPath) as! ContactCell
        
            currentCell.editable.toggle()
            currentCell.name.isEnabled.toggle()
            currentCell.name.isHighlighted.toggle()
            currentCell.phoneNumber.isEnabled.toggle()
            currentCell.email.isEnabled.toggle()
            currentCell.deleteContact.isHidden.toggle()
            
            if (currentCell.editable) {
                currentCell.editContact.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
                currentCell.setShadowElevation(ShadowElevation(rawValue: 8), for: .normal)
                currentCell.name.borderStyle = .roundedRect
                currentCell.phoneNumber.borderStyle = .roundedRect
                currentCell.email.borderStyle = .roundedRect
                
            }else{
                NetworkManager.shared.modifyContact(id: String(UserData.shared.contacts[indexPath.row].id), contact_name: currentCell.name.text!, contact_email: currentCell.email.text!, contact_phone: currentCell.phoneNumber.text!, completionHandler: {
                    success in
                    
                    if(success){
                        NetworkManager.shared.getContacts(completionHandler: {
                            contact in

                            UserData.shared.contacts = contact
                            currentCell.editContact.setImage(UIImage(systemName: "pencil"), for: .normal)
                            currentCell.setShadowElevation(ShadowElevation(rawValue: 2), for: .normal)
                            currentCell.name.borderStyle = .none
                            currentCell.phoneNumber.borderStyle = .none
                            currentCell.email.borderStyle = .none
                            
                        })
                    }else{
                        print("Nope")
                    }
                })
                
        
                
            }
        }
            
        cell.deleteButtonAction = {
            
            let currentCell = collectionView.cellForItem(at: indexPath) as! ContactCell
            currentCell.editable = false
            currentCell.name.isEnabled.toggle()
            currentCell.phoneNumber.isEnabled.toggle()
            currentCell.deleteContact.isHidden.toggle()
            currentCell.editContact.setImage(UIImage(systemName: "pencil"), for: .normal)
            currentCell.setShadowElevation(ShadowElevation(rawValue: 2), for: .normal)
            collectionView.deleteItems(at: [indexPath])
            
            NetworkManager.shared.deleteContact(id: String(UserData.shared.contacts[indexPath.row].id), completionHandler: {
                success in
                
                if(success){
                    NetworkManager.shared.getContacts(completionHandler: {
                        contact in
                        
                            UserData.shared.contacts = contact
                            //self.collectionView.reloadData()
                        
                        
                    })
                }else{
                    print("nope")
                }
            })
            
        
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
                return CGSize(width: self.view.bounds.width - 20, height: 150)
            }else{
                return CGSize(width: self.view.bounds.width - 20, height: 100.0)
            }

        }
    
}
