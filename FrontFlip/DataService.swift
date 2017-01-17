//
//  DataService.swift
//  FrontFlip
//
//  Created by Menan on 2017-01-07.
//  Copyright © 2017 Frontflip. All rights reserved.
//
// SINGLETON CLASS TO TALK TO THE FIREBASE DATABASE AND STORAGE

import Foundation
import Firebase
import SwiftKeychainWrapper

//Root of Database
let DATABASE_BASE = FIRDatabase.database().reference()
let STORAGE_BASE = FIRStorage.storage().reference()


//SINGLETON CLASS
class DataService {
    
    
    //INSTANCE OF SINGLETON CLASS
    static var ds = DataService()
    
    //DATABASE SECURE VARIABLES

    //Private Variable for Root Of Database
    private let _DATABASE_BASE = DATABASE_BASE
    //Private Variable for Root For Users Endpoint
    private let _DATABASE_BASE_USERS = DATABASE_BASE.child("users")
    //Private Variable for Root For Campaings Endpoint
    private let _DATABASE_BASE_CAMPAIGNS = DATABASE_BASE.child("campaigns")

    
    
    //GET Variable for Root Of Database
       var REF_DATABASE_BASE: FIRDatabaseReference {
        return _DATABASE_BASE
    }
    //GET Variable for Root Of USERS ENDPOINT IN DATABASE
    var DATABASE_BASE_USERS: FIRDatabaseReference {
        return _DATABASE_BASE_USERS
    }
    //GET Variable for Root Of CAMPAINGS ENDPOINT IN DATABASE
    var DATABASE_BASE_CAMPAIGNS: FIRDatabaseReference {
        return _DATABASE_BASE_CAMPAIGNS
    }
    
    
    //GET Variable for CURRENT USER
    var REF_USER_CURRENT: FIRDatabaseReference {
        let user = self._DATABASE_BASE_USERS.child(CURRENTUSER!)
        return user
    }
    //STORAGE SECURE VARIABLES
    //Private Variable for Root Of BrandImage Endpoint
    private let _STORAGEBASE_BASE_BRAND_IMAGE = STORAGE_BASE.child("brandImage")
    //Private Variable for Root Of Campaign Image Endpoint
    private let _STORAGEBASE_BASE_BRAND_CAMPAIGN = STORAGE_BASE.child("campaignImage")
    //Private Variable for Root Of Confirm Image Endpoint
    private let _STORAGEBASE_BASE_CONFIRM_IMAGE = STORAGE_BASE.child("confirmImages")


    //GET Variable for Root Of BRANDIMAGE ENDPOINT IN STORAGE
    var STORAGEBASE_BASE_BRAND_IMAGE: FIRStorageReference {
        return _STORAGEBASE_BASE_BRAND_IMAGE
    }
    //GET Variable for Root Of CAMPAIGNIMAGE ENDPOINT IN STORAGE
    var STORAGEBASE_BASE_BRAND_CAMPAIGN: FIRStorageReference {
        return _STORAGEBASE_BASE_BRAND_CAMPAIGN
    }
    //GET Variable for Root Of CONFIRMIMAGE ENDPOINT IN STORAGE
    var STORAGEBASE_BASE_CONFIRM_IMAGE: FIRStorageReference {
        return _STORAGEBASE_BASE_CONFIRM_IMAGE
    }
    
    //DATABASE FUNCTIONS
    func createNewUserInDatabase(uid: String, userData: Dictionary<String,String>) {
        DATABASE_BASE_USERS.child(uid).updateChildValues(userData)
    }
}
