//
//  LoginUser.swift
//  FireChat
//
//  Created by Cédric Bahirwe on 15/07/2021.
//

import Foundation

struct LoginModel {
    var email: String = ""
    var password: String = ""
    
    var isvalid: Bool {
        !email.isEmpty && password.count > 6
    }
}
