//
//  AuthenticationViewModel.swift
//  FireChat
//
//  Created by Cédric Bahirwe on 17/07/2021.
//

import Foundation
import Firebase

class AuthenticationService: ObservableObject {
    @Published var loginUser = LoginModel()
    @Published var regUser = RegisterModel()
        
    
    public func authenticateUser() {
        guard loginUser.isvalid else { return }
        FirebaseAuth
            .Auth.auth()
            .signIn(withEmail: loginUser.email,
                    password: loginUser.password) { (authResult, error) in
                guard error == nil else {
                    print("Failed to login in user")
                    return
                }
                
                guard let result = authResult else {
                    return
                }
                
                let user = result.user
                print("Login User \(user)")
                
            }
    }
    /// Register a user on `Firebase` using `email` and `password`
    public func registerUser() {
        guard regUser.isvalid else { return }
        FirebaseAuth.Auth.auth().createUser(withEmail: regUser.email,
                                            password: regUser.password) { (authResult, error) in
            
            guard error == nil else {
                print("Error creating user")
                return
            }
            
            guard let result = authResult else {
                 return
            }
            
            
            let user = result.user
            print("Created User \(user)")
            
            
        }
    }
    
    
    
}
