//
//  ContentView.swift
//  FireChat
//
//  Created by Cédric Bahirwe on 14/07/2021.
//

import SwiftUI

struct ContentView: View {
    @StateObject var authVm = AuthenticationService()
    var body: some View {
        NavigationView {
            ConversationsView()
                .blur(radius: authVm.isLoggedIn ? 0 : 1)
                .fullScreenCover(isPresented: $authVm.isLoggedIn.inverted()) {
                    LoginView(authVm: authVm)
                }
        }
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
