//
//  LoginView.swift
//  FireChat
//
//  Created by Cédric Bahirwe on 15/07/2021.
//

import SwiftUI
import FirebaseAuth
import FBSDKLoginKit
import UIKit

let size = UIScreen.main.bounds.size

struct LoginView: View {
    @ObservedObject var authVm: AuthenticationService
    @State private var showLoginError = false
    @State private var goToRegistration = false
    
    private let fbBgColor = Color(red: 0.097, green: 0.466, blue: 0.949)
    
    var body: some View {
        NavigationView {
            VStack(spacing: 15) {
                VStack(spacing: 1) {
                    ZStack {
                        NavigationLink(
                            destination: RegisterView(authVm: authVm),
                            isActive: $goToRegistration) { }
                        LOGO()
                    }
                    Text("FireChat")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.main)
                    
                }
                TextField("Email...",
                          text: $authVm.loginUser.email)
                    .textContentType(.emailAddress)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.primary)
                    )
                SecureField("Password...",
                            text: $authVm.loginUser.password)
                    .textContentType(.password)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.primary)
                    )
                
                
                
                Button(action: login) {
                    Text("Log In")
                        .bold()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 45)
                        .background(Color.orange)
                        .cornerRadius(8)
                }
                .alert(isPresented: $showLoginError)  {
                    Alert(title: Text("Woops!!!"),
                          message: Text("Please enter all to log in"),
                          dismissButton: .destructive(Text("Dismiss")))
                    
                }
                
                VStack {
                    FBLoginButtonView(didGetCredFromFb: authVm.manageFbCredential)
                        .frame(maxWidth: 210)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 45)
                .background(fbBgColor)
                .cornerRadius(8)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Login")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement:.navigationBarTrailing) {
                    
                    
                    Button("Register") {
                        goToRegistration.toggle()
                    }
                }
            }
            
        }
    }
    
    // Validations
    private func login() {
        showLoginError = !authVm.loginUser.isvalid
        hideKeyboard()
        authVm.authenticateUser()
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(authVm: AuthenticationService())
    }
}

struct LOGO: View {
    var lSize: CGFloat = 45
    var body: some View {
        Image("cloudy")
            .resizable()
            .renderingMode(.template)
            .scaledToFit()
            .foregroundColor(.white)
            .frame(width: lSize, height: lSize)
            .padding()
            .background(Color("orange"))
            .cornerRadius(30)
            .padding(5)
    }
}

fileprivate struct FBLoginButtonView: UIViewRepresentable {
    
    var didGetCredFromFb: (AuthCredential) -> Void
    //    didSignoutFromFb: () -> Void
    func makeUIView(context: Context) ->  UIButton {
        let loginButton = FBLoginButton()
        loginButton.permissions = ["email", "public_profile"]
        loginButton.delegate = context.coordinator
        return loginButton
    }
    func updateUIView(_ uiView: UIButton, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, LoginButtonDelegate {
        
        let parent: FBLoginButtonView
        init(_ parent: FBLoginButtonView) {
            self.parent = parent
        }
        func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
            
            guard let token = result?.token?.tokenString else {
                print("User failed to log in with facebook")
                return
            }
            
            let facebookRequest = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                             parameters: ["fields" : "email, name"],
                                                             tokenString: token,
                                                             version: nil,
                                                             httpMethod: .get)
            
            facebookRequest.start { (_, result, error) in
                guard let result = result as? [String : Any],
                      error == nil else {
                    print("Failed to make Facebook graph request")
                    return
                }
                
                print(result)
                
                guard let userName = result["name"] as? String,
                      let email = result["email"] as? String else {
                    print("Failed to make email and name from Tacebook request")
                    return
                }
                
                let nameComponents = userName.components(separatedBy: " ")
                guard nameComponents.count == 2 else { return }
                
                let firstName = nameComponents[0]
                let lastName = nameComponents[1]
                
                FCDatabaseManger.shared.userExists(with: email) { exists in
                    if !exists {
                        let fcUser = FCUser(firstName: firstName, lastName: lastName, email: email)
                        FCDatabaseManger.shared.insertUser(with: fcUser)
                    }
                }
                let credential = FacebookAuthProvider.credential(withAccessToken: token)
                
                self.parent.didGetCredFromFb(credential)
            }
            
        }
        
        func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
            print("No operation for now")
        }
        
        
    }
}
