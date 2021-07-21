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
    
    private init () { }

}


// MARK: - Account Management
extension FCDatabaseManger {
    
    
    /// Check whether a user exists
    /// - Parameters:
    ///   - email: email to check against
    ///   - completion: whether the user already exist
    public func userExists(with email: String,
                                completion: @escaping(Bool) -> Void) {
        
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        
        database.child(safeEmail).observeSingleEvent(of: .value) { snapShot in
            guard let _ = snapShot.value as? String else {
                completion(false)
                return
            }
            completion(false)
        }
    }
    
    /// Insert a user to the database
    /// - Parameter user: the user to insert
    public func insertUser(with user: FCUser) {
        print("User Stored to db")
        database.child(user.safeEmail).setValue([
            "firstName" : user.firstName,
            "lastName" : user.lastName
        ])
    }
    
}
