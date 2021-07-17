//
//  AuthenticationViewModel.swift
//  FireChat
//
//  Created by Cédric Bahirwe on 17/07/2021.
//

import Foundation
import Firebase
import FirebaseAuth

struct FCError: Identifiable {
    var id: String { message }
    var message: String = ""
}

class AuthenticationService: ObservableObject {
    @Published var loginUser = LoginModel()
    @Published var regUser = RegisterModel()
        
    @Published var isLoggedIn = false
    
    @Published var regError: FCError?

    
    init() {
//        signOut()
        print("Signing ")
        validateAuth()
    }
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
                self.isLoggedIn = true
                
            }
    }
    /// Register a user on `Firebase` using `email` and `password`
    public func registerUser() {
        guard regUser.isvalid else { return }
        
        FCDatabaseManger.shared.userExists(with: self.regUser.email) { [weak self] userExists in
            
            guard let strongSelf = self else { return }
            
            guard !userExists else {
                strongSelf.regError?.message = "Email address already exists"
                print("User already exists")
                return
            }
            
            FirebaseAuth.Auth.auth().createUser(withEmail: strongSelf.regUser.email,
                                                password: strongSelf.regUser.password) { (authResult, error) in
                
                guard error == nil else {
                    print("Error creating user \(error!.localizedDescription)")
                    return
                }
                
                guard authResult  != nil else { return }
                
                FCDatabaseManger.shared.insertUser(with: strongSelf.regUser.toFCUser())
                strongSelf.isLoggedIn = true
            }
        }
    }
    
    
    
    public func validateAuth() {
        isLoggedIn = FirebaseAuth.Auth.auth().currentUser != nil
    }
    
    public func signOut() {
        do {
            try FirebaseAuth.Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
    }
}
