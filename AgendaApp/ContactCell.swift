//
//  ContactCell.swift
//  AgendaApp
//
//  Created by user177578 on 3/5/21.
//  Copyright © 2021 Apps2t. All rights reserved.
//

import Foundation
import UIKit
 
class ContactCell: UITableViewCell {
 
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var labelCell: UILabel!
 
    override func awakeFromNib() {
    super.awakeFromNib()

        // SHADOW AND BORDER FOR CELL
        //yourTableViewCell.contentView.layer.cornerRadius = 5
        self.contentView.layer.borderWidth = 0.5
        self.contentView.layer.borderColor = UIColor.lightGray.cgColor
        self.contentView.layer.masksToBounds = true
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect:self.bounds, cornerRadius:self.contentView.layer.cornerRadius).cgPath
   }
 
    override func setSelected(_ selected: Bool, animated: Bool) {
       super.setSelected(selected, animated: animated)
 
       // Configure the view for the selected state
    }
}

