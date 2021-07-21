//
//  FCAuthenticationService.swift
//  FireChat
//
//  Created by Cédric Bahirwe on 21/07/2021.
//

import Foundation
import Firebase
import FirebaseAuth
import FBSDKLoginKit

struct FCError: Identifiable {
    var id: String { message }
    var message: String = ""
}

class FCAuthenticationService: ObservableObject {
    @Published var loginUser = LoginModel()
    @Published var regUser = RegisterModel()
    
    @Published var isLoggedIn = false
    @Published var regError: FCError?
    
    init() {
        validateAuth()
    }
    
    
    public func manageFbCredential(credential: AuthCredential) {
        FirebaseAuth.Auth.auth().signIn(with: credential) { (authResult, error) in
            guard authResult != nil , error == nil else {
                if let error = error {
                    print("Facebook credential failed, MFA may be needed - \(error)")
                }
                return
            }
            print("Successfully logged user in Firebase")
            self.isLoggedIn = true
        }
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
        
        FCDatabaseManger.shared.userExists(with: regUser.email) { [weak self] userExists in
            
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
    
    public func confirmSignOut() {
        signOut()
    }
    
    private func signOut() {
        
        // Log out Facebook
        FBSDKLoginKit.LoginManager().logOut()
        
        // Google Log out
//        GIDSignIn.sharedInstance.signOut()
        
        // Log out Firebase
        do {
            try FirebaseAuth.Auth.auth().signOut()
            
            isLoggedIn = false
        } catch {
            print(error.localizedDescription)
        }
    }
}
