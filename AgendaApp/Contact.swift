//
//  Contact.swift
//  AgendaApp
//
//  Created by user177578 on 3/7/21.
//  Copyright © 2021 Apps2t. All rights reserved.
//

import Foundation


struct User: Codable {
    
    var user: String
    var pass: String
    var contacts: Contacts
    
}

typealias Contacts = [Contact]

struct Contact: Codable{

    var name: String
    var phoneNumber: String
    
}

