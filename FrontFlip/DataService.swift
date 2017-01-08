//
//  DataService.swift
//  FrontFlip
//
//  Created by Menan on 2017-01-07.
//  Copyright © 2017 Frontflip. All rights reserved.
//

import Foundation
import Firebase

//Root of Database
let DATABASE_BASE = FIRDatabase.database().reference()

class DataService {
    
    static var ds = DataService()

    //Private Variable for Root Of Database
    private let _DATABASE_BASE = DATABASE_BASE
    //Private Variable for Root For Users Endpoint
    private let _DATABASE_BASE_USERS = DATABASE_BASE.child("users")
    

       var REF_DATABASE_BASE: FIRDatabaseReference {
        return _DATABASE_BASE
    }
    
    var DATABASE_BASE_USERS: FIRDatabaseReference {
        return _DATABASE_BASE_USERS
    }

    func createNewUserInDatabase(uid: String, userData: Dictionary<String,String>) {
        DATABASE_BASE_USERS.child(uid).updateChildValues(userData)
    }
}
