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
    let defaults = UserDefaults.standard
    
    let url = URL(string: "Some API URL")
    let apiKey = "API Key"
    
    func getUser(user: String, pass: String) {
        
        var queryParameters = [
            "user": user,
            "pass": pass]
        
        AF.request(self.url as! URLConvertible, method: .get, parameters: queryParameters, encoding: URLEncoding(destination: .queryString), headers: nil).responseDecodable(of: User.self){
            response in
            //TO DO when response obtained

        }
        
    }
    
    func createUser(user: String, pass: String){
        
        var queryParameters = [
            "user": user,
            "pass": pass]
        
        AF.request(self.url as! URLConvertible, method: .post, parameters: queryParameters, encoding: URLEncoding(destination: .queryString), headers: nil).responseDecodable(of: User.self){
            response in
            
        }

    }
    
    func editUser(newPass: String){
        
        var queryParameters = [
            "pass": newPass]
        
        var headers: HTTPHeaders = ["Authorization": self.apiKey]
        
        AF.request(self.url as! URLConvertible, method: .post, parameters: queryParameters, encoding: URLEncoding(destination: .queryString), headers: headers ).responseDecodable(of: User.self){
            response in
            
        }
    }
    
    func createContact(contact: Contact){
        
        var queryParameters = [
            "contact": contact]
        
        var headers: HTTPHeaders = ["Authorization": self.apiKey]
        
        AF.request(self.url as! URLConvertible, method: .post, parameters: queryParameters, encoding: URLEncoding(destination: .queryString), headers: headers ).responseDecodable(of: User.self){
            response in
            
        }
        
    }
    
    func modifyContact(contactAt: Int, contact: Contact){
        
        var queryParameters = [
            "contact_id": contactAt,
            "contact": contact] as [String : Any]
        
        var headers: HTTPHeaders = ["Authorization": self.apiKey]
        
        AF.request(self.url as! URLConvertible, method: .post, parameters: queryParameters, encoding: URLEncoding(destination: .queryString), headers: headers ).responseDecodable(of: User.self){
            response in
            
        }
    }
    
    func deleteContact(contactAt: Int){
        
        var queryParameters = [
            "contact_id": contactAt]
        
        var headers: HTTPHeaders = ["Authorization": self.apiKey]
        
        AF.request(self.url as! URLConvertible, method: .post, parameters: queryParameters, encoding: URLEncoding(destination: .queryString), headers: headers ).responseDecodable(of: User.self){
            response in
            
        }
    }
    
    func deleteUser(id: Int){
        
        var queryParameters = [
            "id": id]
        
        var headers: HTTPHeaders = ["Authorization": self.apiKey]
        
        AF.request(self.url as! URLConvertible, method: .post, parameters: queryParameters, encoding: URLEncoding(destination: .queryString), headers: headers ).responseDecodable(of: String.self){
            response in
            
        }
    }
    
    /// -DEFAULTS
    func saveUser (user: String, pass: String, contacts: [Contact]){
            let user = User(user: user, pass: pass, contacts: contacts)

            let encodedUser = try? JSONEncoder().encode(user)
            self.defaults.setValue(encodedUser, forKey: "user")
        }
        
        func checkUser () -> Bool {
            if (self.defaults.object(forKey: "user") != nil){
                return true
            } else {
                return false
            }
        }
        
        func getUser() -> User {
            
            // Sirve para devolver un usuario temporal, si no entra en la condición
            var tempUser = User(user: "Guest", pass: "", contacts: [])
           
            let currentUser: Data = self.defaults.object(forKey: "user") as! Data
            
            if let decodedUser = try? JSONDecoder().decode(User.self, from: currentUser){
                return decodedUser
            }
            return tempUser
        }
    
}
