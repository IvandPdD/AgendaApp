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
    
    var contactName: [String] = ["jsahfue", "ksjdfliweas", "skdhfjwe", "jaskdfje", "kasjdfewj", "dafkhsjeiujfa", "kdsajfei", "sdhjfsidfjhe", "sdkjfeo"]
    var contactNumber: [String] = ["123 12 12 12", "567 56 56 56", "789 45 34 23", "465 23 75 23", "978 23 67 34", "456 86 45 83", "236 75 73 86", "234 64 72 83", "236 84 83 56"]
    
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
    
    @IBAction func confirmAddContact(_ sender: MDCButton) {
        
//        //Peticion al NetworkManager para crear contacto si pudiese hacer peticiones a la API
//        self.contactName.append(self.addName.text!)
//        self.contactNumber.append(self.addNumber.text!)
//        self.dismiss(animated: true, completion: nil)
//        self.collectionView.reloadData()
    }
    
}


extension MainVC: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.contactName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell",
                                                            for: indexPath) as! ContactCell
        cell.photo.image = UIImage(systemName: "person.circle.fill")
        cell.photo.tintColor = .systemTeal
        cell.name.text = self.contactName[indexPath.row]
        cell.phoneNumber.text = self.contactNumber[indexPath.row]
        cell.editContact.setImage(UIImage(systemName: "pencil"), for: .normal)
        cell.editContact.backgroundColor = .white
        cell.editContact.enableRippleBehavior = true
        cell.deleteContact.enableRippleBehavior = true
        
        cell.editButtonAction = {
            //Peticion al NetworkManager para borrar contacto si pudiese hacer peticiones a la API
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
                self.contactName[indexPath.row] = currentCell.name.text!
                self.contactNumber[indexPath.row] = currentCell.phoneNumber.text!
                currentCell.editContact.setImage(UIImage(systemName: "pencil"), for: .normal)
                currentCell.setShadowElevation(ShadowElevation(rawValue: 2), for: .normal)
            }
        }
            
        cell.deleteButtonAction = {
            //Peticion al NetworkManager para borrar contacto si pudiese hacer peticiones a la API
            let currentCell = collectionView.cellForItem(at: indexPath) as! ContactCell
            self.editable.toggle()
            currentCell.name.isEnabled.toggle()
            currentCell.phoneNumber.isEnabled.toggle()
            currentCell.deleteContact.isHidden.toggle()
            currentCell.editContact.setImage(UIImage(systemName: "pencil"), for: .normal)
            currentCell.setShadowElevation(ShadowElevation(rawValue: 2), for: .normal)
            self.contactName.remove(at: indexPath.row)
            self.contactNumber.remove(at: indexPath.row)
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
