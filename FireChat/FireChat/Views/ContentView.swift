//
//  ContentView.swift
//  FireChat
//
//  Created by Cédric Bahirwe on 14/07/2021.
//

import SwiftUI

struct ContentView: View {
    @StateObject var authVm = FCAuthenticationService()
    @State private var selection = 0
    var body: some View {
        
        TabView(selection: $selection) {
            NavigationView {
                ConversationsView()
                    .blur(radius: authVm.isLoggedIn ? 0 : 1)
                    .fullScreenCover(isPresented: $authVm.isLoggedIn.inverted()) {
                        LoginView(authVm: authVm)
                    }
            }
            .tabItem {
                Label("Chats", systemImage: "house")
            }
            .tag(0)
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "gear")
                }
                .tag(1)
        }
//        .accentColor(.main)
        .environmentObject(authVm)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


extension Binding where Value == Bool {
    func inverted() -> Binding<Bool> {
        Binding(
            get: { !wrappedValue },
            set: { wrappedValue = !$0 }
        )
        
    }
}
