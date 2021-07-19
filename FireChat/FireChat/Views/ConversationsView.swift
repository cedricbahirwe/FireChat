//
//  ConversationsView.swift
//  FireChat
//
//  Created by Cédric Bahirwe on 15/07/2021.
//

import SwiftUI

struct ConversationsView: View {
    @EnvironmentObject var authVm: AuthenticationService
    var body: some View {
        VStack {
            Color.white
                .ignoresSafeArea()
            
            Text(authVm.isLoggedIn.description)
            
        }
        .navigationTitle("Conversations")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                
                Button("Log Out", action: authVm.signOut)
                
            }
        }
    }
}

struct ConversationsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ConversationsView()
                .environmentObject(AuthenticationService())
        }
    }
}
