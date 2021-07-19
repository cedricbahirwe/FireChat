//
//  ProfileView.swift
//  FireChat
//
//  Created by Cédric Bahirwe on 19/07/2021.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authVm: AuthenticationService
    @State private var showLogoutAlert = false
    var body: some View {
        NavigationView {
            VStack {
                Text("Hello, World!")
            }
            .actionSheet(isPresented: $showLogoutAlert) {
                ActionSheet(title: Text("Log Out Confirmation"),
                            message: Text("Do you really want to log out?"),
                            buttons: [
                                .destructive(Text("Log Out"), action: authVm.confirmSignOut),
                                .cancel()
                            ])
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    Button("Log Out") {
                        showLogoutAlert.toggle()
                    }
                    
                }
            }
            
            .navigationTitle("Profile")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
