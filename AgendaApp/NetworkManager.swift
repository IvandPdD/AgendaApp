//
//  NetworkManager.swift
//  AgendaApp
//
//  Created by user177578 on 3/7/21.
//  Copyright © 2021 Apps2t. All rights reserved.
//
import Foundation
import Alamofire

class NetworkManager{
    
    static var shared: NetworkManager = NetworkManager()
    
    func getContacts(completion: @escaping (Contact) -> Void) {
        
        let url = URL(string: "Some URL Api")
        
        
        var queryParameters = [
            "parameter1": "",
            "parameter2": "",
            "key": "API KEY"] as [String : Any]
        
        AF.request(url as! URLConvertible, method: .get, parameters: queryParameters, encoding: URLEncoding(destination: .queryString), headers: nil).responseDecodable(of: Contact.self){
            response in
            //TO DO when response obtained

        }
        
    }
    
    
}
