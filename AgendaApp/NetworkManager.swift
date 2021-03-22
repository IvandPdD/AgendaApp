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
    
    var result = ""
    var resultContact = ""
        
    static var shared:NetworkManager = NetworkManager()
    static var respuesta = ""
    static var respuestaContacto = ""
    var token = ""
        
    func createUser(name: String, email: String, pass: String, confirmPass: String, completion: @escaping(Bool)->Void ){
                
        //alamcenamos la URL de la api
        let url = URL(string: "https://conctactappservice.herokuapp.com/api/register")!
                
        //preparamos las variables a enviar
        let register: [String:Any] = ["name": name, "email": email, "password": pass, "password_confirmation": confirmPass]
                
        //las transformamos en JSON
        let registerJson = try? JSONSerialization.data(withJSONObject: register)
                
        //llamamos a la request junto a la URL
        var request = URLRequest(url: url)
                
        //indicamos el protocolo
        request.httpMethod = "POST"
                
        // contenido del body
        request.httpBody = registerJson
                
        //le introducimos los headers necesarios
        request.headers = ["Content-Type": "application/json"]
                
        //se envia la peticion usando alamofire
        //utilizamos el completion handler para sincronizar peticiones
        AF.request(request).validate().response{ response in
                    
            DispatchQueue.global().sync(){
                switch response.result{
                
                case .success(_):
                    completion(true)
                case .failure(_):
                    completion(false)
                }
            }
        }
    }
        
    func loginUser(email: String, pass: String,completion: @escaping(Bool) -> Void ){
                
        struct LoginUser: Codable {
            let token: String
        }
                
        //alamcenamos la URL de la api en una varianle
        let url = URL(string: "https://conctactappservice.herokuapp.com/api/login")!
                
        //preparamos las variables a enviar
        let login: [String:Any] = ["email": email , "password": pass]
                
        //las transformamos en JSON
        let jsonLogin = try? JSONSerialization.data(
            withJSONObject: login,
            options: [])
                
        //llamamos a la request, dandole la url
        var request = URLRequest(url: url)
                
        //se le indica el protocolo con el que se envia
        request.httpMethod = "POST"
                
        //se le indica el contenido del body
        request.httpBody = jsonLogin
                
        //el header
        request.headers = ["Content-Type": "application/json"]
                
        //se envia la peticion usando alamofire
        AF.request(request).validate().response(){
            response in
            
            DispatchQueue.global().sync {
                switch response.result{
                    
                case .success(_):
                    let user = try? JSONDecoder().decode(LoginUser.self , from: response.data!)
            
                    self.token = user!.token
                    
                    completion(true)
                    
                case .failure(_):
                    completion(false)
                }

            }
        }
    }
    
    func getContacts(completion: @escaping([ContactElement]) -> Void) {

        let url = URL(string: "https://conctactappservice.herokuapp.com/api/showContact")
        var contact: [ContactElement] = []

        var request = URLRequest(url: url!)

        request.httpMethod = "GET"

        request.headers = ["Content-Type": "application/json",
                           "Authorization":"Bearer" + token]

        AF.request(request).validate().responseJSON {
            response in

                if (response.error == nil) {
                    do {
                        contact = try JSONDecoder().decode([ContactElement].self, from: response.data!)
                        completion(contact)

                    } catch {
                        print("No hay contactos")
                    }
                }
        }
    }
    
        
        func createContact(name: String, email: String, phoneNumber: String, completion: @escaping(Bool) -> Void){
                
            struct Contact: Encodable {
                    
                let contact_name: String
                let contact_email: String
                let contact_phone: String
            }
                
            //alamcenamos la URL de la api en una varianle
            let url = URL(string: "https://conctactappservice.herokuapp.com/api/create")!
            
            //preparamos las variables a enviar
            let contact: [String:Any] = ["contact_name": name, "contact_email": email, "contact_phone": phoneNumber]
            
            //las transformamos en JSON
            let jsonContact = try? JSONSerialization.data(
            withJSONObject: contact)
            
            //llamamos a la request, dandole la url
            var request = URLRequest(url: url)
            
            //se le indica el protocolo con el que se envia
            request.httpMethod = "POST"
            
            //se le indica el contenido del body
            request.httpBody = jsonContact
        
            //el header
            request.headers = ["Content-Type": "application/json",
                               "Authorization":"Bearer" + self.token]
            
            //se envia la peticion usando alamofire
            AF.request(request).validate().response {
                response in
                
                switch response.result{
                    
                case .success(_):
                    completion(true)
                case .failure(_):
                    completion(false)
                }
            }
        }
        
        
        func deleteContact(id: String, completion: @escaping(Bool) -> Void){
            
            struct Delete: Encodable {
                        
                let id: String
            }
            
            //alamcenamos la URL de la api en una varianle
            let url = URL(string: "https://conctactappservice.herokuapp.com/api/eraseContact")!
                    
            //preparamos las variables a enviar
            let login: [String:Any] = ["id": id]
                    
            //las transformamos en JSON
            let jsonLogin = try? JSONSerialization.data(
                withJSONObject: login,
                options: [])
                    
            //llamamos a la request, dandole la url
            var request = URLRequest(url: url)
                    
            //se le indica el protocolo con el que se envia
            request.httpMethod = "POST"
                    
            //se le indica el contenido del body
            request.httpBody = jsonLogin
                    
            //el header
            request.headers = ["Content-Type": "application/json",
                               "Authorization":"Bearer" + self.token]
                    
            //se envia la peticion usando alamofire
            AF.request(request).validate().response(){
                response in
                
                switch response.result{
                    
                case .success(_):
                    completion(true)
                case .failure(_):
                    completion(false)
                }
            }
        }
        
        func deleteUser(completion: @escaping(Bool) -> Void){
            
            //alamcenamos la URL de la api en una varianle
            let url = URL(string: "https://conctactappservice.herokuapp.com/api/eraseUser")!
                    
            //llamamos a la request, dandole la url
            var request = URLRequest(url: url)
                    
            //se le indica el protocolo con el que se envia
            request.httpMethod = "POST"
                    
            //el header
            request.headers = ["Content-Type": "application/json",
                               "Authorization":"Bearer" + self.token]
                    
            //se envia la peticion usando alamofire
            AF.request(request).validate().response(){
                response in
                
                DispatchQueue.global().sync {
                    switch response.result{
                    
                    case .success(_):
                        completion(true)
                    case .failure(_):
                        completion(false)
                    }
                }
            }
        }
        
        func forgotPass(email: String, completion: @escaping(Bool) -> Void){
            
            struct forgot: Encodable {
                        
                let email: String
            }
            
                    
            //alamcenamos la URL de la api en una varianle
            let url = URL(string: "https://conctactappservice.herokuapp.com/api/password/email")!
                    
            //preparamos las variables a enviar
            let contact: [String:Any] = [ "email": email]
                    
            //las transformamos en JSON
            let jsonLogin = try? JSONSerialization.data(
                withJSONObject: contact,
                options: [])
                    
            //llamamos a la request, dandole la url
            var request = URLRequest(url: url)
                    
            //se le indica el protocolo con el que se envia
            request.httpMethod = "POST"
                    
            //se le indica el contenido del body
            request.httpBody = jsonLogin
                    
            //el header
            request.headers = ["Content-Type": "application/json"]
                    
            //se envia la peticion usando alamofire
            AF.request(request).validate().response(){
                response in
                
                let defaults = UserDefaults.standard
                
                switch response.result{
                
                case .success(_):
                    completion(true)
                case .failure(_):
                    completion(false)
                }
            }
        }
        
        func modifyContact(id: String, name: String, email: String, phoneNumber: String, completion: @escaping(Bool) -> Void){
            
            struct Modify: Encodable {
                    
                let id: String
                let contact_name: String
                let contact_email: String
                let contact_phone: String
            }
            
            let string_id = String(id)
                    
            //alamcenamos la URL de la api en una varianle
            let url = URL(string: "https://conctactappservice.herokuapp.com/api/updateContact/" + string_id)!
                    
            //preparamos las variables a enviar
            let contact: [String:Any] = ["contact_name": name, "contact_email": email, "contact_phone": phoneNumber]
                    
            //las transformamos en JSON
            let jsonLogin = try? JSONSerialization.data(
                withJSONObject: contact,
                options: [])
                    
            //llamamos a la request, dandole la url
            var request = URLRequest(url: url)
                    
            //se le indica el protocolo con el que se envia
            request.httpMethod = "POST"
                    
            //se le indica el contenido del body
            request.httpBody = jsonLogin
                    
            //el header
            request.headers = ["Content-Type": "application/json",
                               "Authorization":"Bearer" + self.token]
                    
            //se envia la peticion usando alamofire
            AF.request(request).validate().response(){
                response in
                
                let defaults = UserDefaults.standard
                
                switch response.result{
                
                case .success(_):
                    completion(true)
                case .failure(_):
                    completion(false)
                }
            }
        }
    
    func changePass(newPass: String, completion: @escaping(Bool)->Void){
        
        struct ChangePass: Encodable {
                
            let pass: String
        }
                
        //alamcenamos la URL de la api en una varianle
        let url = URL(string: "https://conctactappservice.herokuapp.com/api/changePass/")!
                
        //preparamos las variables a enviar
        let contact: [String:Any] = ["pass": newPass]
                
        //las transformamos en JSON
        let jsonLogin = try? JSONSerialization.data(
            withJSONObject: contact,
            options: [])
                
        //llamamos a la request, dandole la url
        var request = URLRequest(url: url)
                
        //se le indica el protocolo con el que se envia
        request.httpMethod = "POST"
                
        //se le indica el contenido del body
        request.httpBody = jsonLogin
                
        //el header
        request.headers = ["Content-Type": "application/json",
                           "Authorization":"Bearer" + self.token]
                
        //se envia la peticion usando alamofire
        AF.request(request).validate().response(){
            response in
            
            switch response.result{
            
            case .success(_):
                completion(true)
            case .failure(_):
                completion(false)
            }
        }
    }
    
}
