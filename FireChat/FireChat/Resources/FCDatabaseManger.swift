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
    
    public func test() {
        database.child("foo").setValue(["somekey" : true])
    }

}


// MARK: - Account Management
extension FCDatabaseManger {
    
    
    /// Check whether a user exists
    /// - Parameters:
    ///   - email: email to check against
    ///   - completion: whether the user already exist
    public func userExists(with email: String,
                                completion: @escaping(Bool) -> Void) {
        database.child(email).observeSingleEvent(of: .value) { snapShot in
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
        database.child(user.email).setValue([
            "firstName" : user.firstName,
            "lastName" : user.lastName
        ])
    }
    
}
