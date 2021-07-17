//
//  RegisterView.swift
//  FireChat
//
//  Created by Cédric Bahirwe on 15/07/2021.
//

import SwiftUI
import FirebaseAuth

struct RegisterView: View {
    @StateObject private var authVm = AuthenticationService()
    @State private var showRegError = false
    @State private var showImagePicker = false
    @State private var showPhotoActionSheet = false
    @State var pickerSourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @State private var inputImage = UIImage.init()
    
    var body: some View {
        VStack(spacing: 15) {
            VStack(spacing: 1) {
                
                ZStack {
                    if inputImage == UIImage.init() {
                        Image(systemName: "person")
                            .resizable()
                            .scaledToFit()
                            .padding(20)
                    } else {
                        Image(uiImage: inputImage)
                            .resizable()
                            .scaledToFill()
                    }
                }
                .frame(width: 100, height: 100)
                .background(Color.main)
                .cornerRadius(50)
                .onTapGesture(perform: didTapChangeProfilePic)
                .actionSheet(isPresented: $showPhotoActionSheet) {
                    ActionSheet(
                        title: Text("Profile Picture"),
                        message: Text("would you like to select a picture?"),
                        buttons: [
                            .default(Text("Take a photo"), action: takeFromCamera),
                            .default(Text("Choose from gallery"), action: pickFromGallery
                            ),
                            .destructive(Text("Cancel"))
                        ])
                }
                Text("FireChat")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.main)
                
            }
            
            TextField("First name",
                      text: $authVm.regUser.firstName)
                .disableAutocorrection(true)
                .textContentType(.givenName)
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.primary)
                )
            
            TextField("Last Name",
                      text: $authVm.regUser.lastName)
                .disableAutocorrection(true)
                .textContentType(.familyName)
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.primary)
                )
            TextField("Email",
                      text: $authVm.regUser.email)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .textContentType(.emailAddress)
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.primary)
                )
            SecureField("Password",
                        text: $authVm.regUser.password)
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
            .alert(isPresented: $showRegError) {
                Alert(title: Text("Woops!!!"),
                      message: Text("Please enter all to create a new account"),
                      dismissButton: .destructive(Text("Dismiss")))
                
            }
            Spacer()
        }
        .padding()
        .fullScreenCover(isPresented: $showImagePicker) {
            ImagePicker(image: $inputImage,
                        sourceType: $pickerSourceType)
        }
        .navigationTitle("Create Account")
    }
    
    // Validations
    private func didPressRegister() {
        showRegError = !authVm.regUser.isvalid
        hideKeyboard()
        authVm.registerUser()
    }
    
    private func didTapChangeProfilePic() {
        print("sho")
        showPhotoActionSheet.toggle()
    }
    
    
    func takeFromCamera() {
        pickerSourceType = .camera
        showImagePicker.toggle()
    }
    
    func pickFromGallery() {
        pickerSourceType = .photoLibrary
        showImagePicker.toggle()
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


