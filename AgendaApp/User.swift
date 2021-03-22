//
//  Contact.swift
//  AgendaApp
//
//  Created by user177578 on 3/7/21.
//  Copyright © 2021 Apps2t. All rights reserved.
//

import Foundation
import UIKit


// MARK: - UserClass
struct User: Codable {
    let id: Int
    let name, email: String

    enum CodingKeys: String, CodingKey {
        case id, name, email
    }
}

struct ContactElement: Codable {
    let id, userID: Int
    let name: String
    let phoneNumber: Int
    let email: String

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case name = "contact_name"
        case phoneNumber = "contact_phone"
        case email = "contact_email"
    }

}

class UserData{
    static var shared: UserData = UserData()
    
    var contacts: [ContactElement] = []
    var photo: UIImageView?
}
