//
//  ConversationsView.swift
//  FireChat
//
//  Created by Cédric Bahirwe on 15/07/2021.
//

import SwiftUI

struct ConversationsView: View {
    
    var body: some View {
        Color.red
            .ignoresSafeArea()
            .navigationTitle("Conversations")
            .navigationBarHidden(true)
            .onAppear() {
                FCDatabaseManger.shared.test()
            }
    }
}

struct ConversationsView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationsView()
    }
}
