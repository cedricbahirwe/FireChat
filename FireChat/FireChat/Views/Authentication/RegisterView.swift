//
//  RegisterView.swift
//  FireChat
//
//  Created by Cédric Bahirwe on 15/07/2021.
//

import SwiftUI

struct RegisterView: View {
    @State private var user = RegisterModel()
    @State private var showRegisterErrorAlert = false
    var body: some View {
        VStack(spacing: 15) {
            VStack(spacing: 1) {
                Image(systemName: "person")
                    .resizable()
                    .renderingMode(.template)
                    .scaledToFit()
                    .foregroundColor(.white)
                    .frame(width: 60, height: 60)
                    .padding(25)
                    .background(Color.main.blur(radius: 10))
                    .cornerRadius(30)
                    .onTapGesture(perform: didTapChangeProfilePic)
                Text("FireChat")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.main)
                
            }
            
            TextField("First name",
                      text: $user.firstName)
                .disableAutocorrection(true)
                .textContentType(.givenName)
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.primary)
                )
            
            TextField("Last Name",
                      text: $user.lastName)
                .disableAutocorrection(true)
                .textContentType(.familyName)
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.primary)
                )
            TextField("Email",
                      text: $user.email)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .textContentType(.emailAddress)
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.primary)
                )
            SecureField("Password...",
                        text: $user.password)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .textContentType(.password)
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.primary)
                )
            
            Button(action: didPressRegister) {
                Text("Register")
                    .bold()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 45)
                    .background(Color.orange)
                    .cornerRadius(8)
            }
            
            .alert(isPresented: $showRegisterErrorAlert)  {
                Alert(title: Text("Woops!!!"),
                      message: Text("Please enter all to create a new account"),
                      dismissButton: .destructive(Text("Dismiss")))
                
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Create Account")
    }
    
    // Validations
    private func didPressRegister() {
       showRegisterErrorAlert = !user.isvalid
        hideKeyboard()
    }
    
    private func didTapChangeProfilePic() {
        
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RegisterView()
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
