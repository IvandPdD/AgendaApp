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
    var currentCell: ContactCell?
    
    var addContact: UIViewController?
    var addButton: MDCFloatingButton?

    override func viewDidLoad() {
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
        addContact = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "addContact")
        addContact?.transitioningDelegate = transitionDelegate
        addContact?.modalPresentationStyle = .custom
        addContact!.modalPresentationCapturesStatusBarAppearance = true
        
        transitionDelegate.customHeight = 250
        transitionDelegate.indicatorMode = .alwaysLine
        transitionDelegate.swipeToDismissEnabled = true
        transitionDelegate.translateForDismiss = 10
        transitionDelegate.tapAroundToDismissEnabled = false
        
        present(self.addContact!, animated: true, completion: nil)
    }
    
}


extension MainVC: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell",
                                                            for: indexPath) as! ContactCell
        cell.photo.image = UIImage(systemName: "person.circle.fill")
        cell.name.text = "Ivan"
        cell.phoneNumber.text = "+34 123 12 12 12"
        cell.editContact.setImage(UIImage(systemName: "pencil"), for: .normal)
        cell.editContact.backgroundColor = .white
        cell.editContact.enableRippleBehavior = true
        cell.deleteContact.enableRippleBehavior = true
        
        cell.editButtonAction = { [unowned self] in
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
                currentCell.editContact.setImage(UIImage(systemName: "pencil"), for: .normal)
                currentCell.setShadowElevation(ShadowElevation(rawValue: 2), for: .normal)
            }
        }
            
        cell.deleteButtonAction = { [unowned self] in

        }

        return cell
    }
    
    func buttonTapped(cell: ContactCell) {
        guard let indexPath = self.collectionView.indexPath(for: cell) else {
                // Note, this shouldn't happen - how did the user tap on a button that wasn't on screen?
                return
            }

            //  Do whatever you need to do with the indexPath

            print("Button tapped on row \(indexPath.row)")
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ContactCell
        
    }
}


