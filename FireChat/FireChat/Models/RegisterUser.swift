//
//  RegisterUser.swift
//  FireChat
//
//  Created by Cédric Bahirwe on 15/07/2021.
//

import Foundation

struct RegisterModel {
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var password: String = ""
    var isvalid: Bool {
        !email.isEmpty
            && password.count > 6
            && !firstName.isEmpty
            && !lastName.isEmpty
    }
}
