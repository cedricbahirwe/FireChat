//
//  FCUser.swift
//  FireChat
//
//  Created by Cédric Bahirwe on 17/07/2021.
//

import Foundation


struct FCUser {
    let firstName: String
    let lastName: String
    let email: String
//    let profilePicUrl: String
    
    
    var safeEmail: String {
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
        
    }
}
