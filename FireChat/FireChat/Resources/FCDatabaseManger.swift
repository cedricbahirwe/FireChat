//
//  FCDatabaseManger.swift
//  FireChat
//
//  Created by Cédric Bahirwe on 17/07/2021.
//

import Foundation
import FirebaseDatabase

final class FCDatabaseManger {
    static let shared = FCDatabaseManger()
    
    private let database = Database.database().reference()
    
//    private init () { }
    
    public func test() {
        database.child("foo").setValue(["somekey" : true])
        
    }
    
    
}


// MARK: - Account Management
extension FCDatabaseManger {
    
    public func userExists(with email: String,
                                completion: @escaping(Bool) -> Void) {
        completion(database.value(forKey: email) != nil)
        
        
    }
    
    /// Insert a user to the database
    /// - Parameter user: the user to insert
    public func insertUser(with user: FCUser) {
        database.child(user.email).setValue([
            "firstName" : user.firstName,
            "lastName" : user.lastName
        ])
    }
    
}
