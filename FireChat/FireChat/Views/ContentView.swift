//
//  ContentView.swift
//  FireChat
//
//  Created by Cédric Bahirwe on 14/07/2021.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isLoggedIn") var isLoggedIn = false
    var body: some View {
        NavigationView {
            
            ConversationsView()
                .blur(radius: isLoggedIn ? 0 : 1)
                .fullScreenCover(isPresented: .constant(!isLoggedIn)) {
                    LoginView()
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
