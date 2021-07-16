//
//  LoginView.swift
//  FireChat
//
//  Created by Cédric Bahirwe on 15/07/2021.
//

import SwiftUI
import FirebaseAuth

let size = UIScreen.main.bounds.size

struct LoginView: View {
    
    @State private var user = LoginModel()
    @State private var showLoginErrorAlert = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 15) {
                VStack(spacing: 1) {
                    LOGO()
                    Text("FireChat")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.main)

                }
                TextField("Email...",
                          text: $user.email)
                    .textContentType(.emailAddress)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.primary)
                    )
                SecureField("Password...",
                            text: $user.password)
                    .textContentType(.password)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.primary)
                    )
                
                Button(action: didPressLogin) {
                    Text("Log In")
                        .bold()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 45)
                        .background(Color.orange)
                        .cornerRadius(8)
                }
                
                .alert(isPresented: $showLoginErrorAlert)  {
                    Alert(title: Text("Woops!!!"),
                          message: Text("Please enter all to log in"),
                          dismissButton: .destructive(Text("Dismiss")))
                    
                }
                Spacer()
            }
            .padding()
            .navigationTitle("Login")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement:.navigationBarTrailing) {
                    
                    NavigationLink(
                        destination: RegisterView(),
                        label: {
                            Text("Register")
                        })
                }
            }
        }
    }
    
    // Validations
    private func didPressLogin() {
        showLoginErrorAlert = !user.isvalid
        hideKeyboard()
        FirebaseAuth
            .Auth.auth()
            .signIn(withEmail: user.email,
                    password: user.password) { (authResult, error) in
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
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
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
