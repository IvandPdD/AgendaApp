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
import Toaster

class SettingsVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var photo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        photo.isUserInteractionEnabled = true
        photo.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if(UserData.shared.photo?.image != nil)
        {
            photo.image = UserData.shared.photo?.image
        }

    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        present(imagePicker, animated: true, completion: nil)
                
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        self.photo.image = image
        UserData.shared.photo?.image = image
        picker.dismiss(animated: true, completion: nil)
            
    }
        
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
            
        picker.dismiss(animated: true, completion: nil)
    }
    
}
