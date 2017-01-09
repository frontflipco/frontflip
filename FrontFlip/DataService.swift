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
let STORAGE_BASE = FIRStorage.storage().reference()

class DataService {
    
    static var ds = DataService()
    
    //DATABASE SECURE VARIABLES

    //Private Variable for Root Of Database
    private let _DATABASE_BASE = DATABASE_BASE
    //Private Variable for Root For Users Endpoint
    private let _DATABASE_BASE_USERS = DATABASE_BASE.child("users")
    //Private Variable for Root For Campaings Endpoint
    private let _DATABASE_BASE_CAMPAIGNS = DATABASE_BASE.child("campaigns")

       var REF_DATABASE_BASE: FIRDatabaseReference {
        return _DATABASE_BASE
    }
    
    var DATABASE_BASE_USERS: FIRDatabaseReference {
        return _DATABASE_BASE_USERS
    }
    var DATABASE_BASE_CAMPAIGNS: FIRDatabaseReference {
        return _DATABASE_BASE_CAMPAIGNS
    }
    
    
    //STORAGE SECURE VARIABLES
    private let _STORAGEBASE_BASE_BRAND_IMAGE = STORAGE_BASE.child("brandImage")
    private let _STORAGEBASE_BASE_BRAND_CAMPAIGN = STORAGE_BASE.child("campaignImage")

    var STORAGEBASE_BASE_BRAND_IMAGE: FIRStorageReference {
        return _STORAGEBASE_BASE_BRAND_IMAGE
    }
    
    var STORAGEBASE_BASE_BRAND_CAMPAIGN: FIRStorageReference {
        return _STORAGEBASE_BASE_BRAND_CAMPAIGN
    }
    
    //DATABASE FUNCTIONS
    func createNewUserInDatabase(uid: String, userData: Dictionary<String,String>) {
        DATABASE_BASE_USERS.child(uid).updateChildValues(userData)
    }
}
