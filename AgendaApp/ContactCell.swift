//
//  ContactCell.swift
//  AgendaApp
//
//  Created by user177578 on 3/5/21.
//  Copyright © 2021 Apps2t. All rights reserved.
//

import Foundation
import UIKit
import MaterialComponents

class ContactCell: MDCCardCollectionCell {
    
    var editable: Bool = false
 
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var editContact: MDCButton!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var deleteContact: MDCButton!
    
    var editButtonAction : (() -> ())?
    var deleteButtonAction : (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.setBorderColor(.gray, for: .normal)
        self.setBorderWidth(0.5, for: .normal)
        self.setShadowColor(.gray, for: .normal)
        self.setShadowColor(.gray, for: .normal)
        self.setShadowElevation(ShadowElevation(rawValue: 2), for: .normal)
        self.layer.masksToBounds = false
        
        self.editContact.addTarget(self, action: #selector(editButtonTapped(_:)), for: .touchUpInside)
        self.deleteContact.addTarget(self, action: #selector(deleteButtonTapped(_:)), for: .touchUpInside)
        
        // SHADOW AND BORDER FOR CELL
        /*self.contentView.layer.cornerRadius = 5
        self.contentView.layer.borderWidth = 0.5
        self.contentView.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.layer.shadowRadius = 1.0
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect:self.bounds, cornerRadius:self.contentView.layer.cornerRadius).cgPath*/
   }
    
    @IBAction func editButtonTapped(_ sender: UIButton){
       editButtonAction?()
     }
    @IBAction func deleteButtonTapped(_ sender: UIButton){
       deleteButtonAction?()
     }
}

