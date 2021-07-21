//
//  ConversationsView.swift
//  FireChat
//
//  Created by Cédric Bahirwe on 15/07/2021.
//

import SwiftUI

struct ConversationsView: View {
    
    var body: some View {
        VStack {
            Color.white
                .ignoresSafeArea()
            
            
        }
        .navigationTitle("Conversations")
    }
}

struct ConversationsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ConversationsView()
                .environmentObject(FCAuthenticationService())
        }
    }
}
