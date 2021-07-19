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
                    FBLogin()
                        .frame(maxWidth: .infinity)
                        .frame(height: 45)
                        .cornerRadius(8)
                }
                
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

struct FBLogin: UIViewRepresentable {
    func makeUIView(context: Context) ->  UIButton {
        let loginButton = FBLoginButton()
        return loginButton
    }
    func updateUIView(_ uiView: UIButton, context: Context) {
        
    }
}
