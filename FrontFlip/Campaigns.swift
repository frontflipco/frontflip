//
//  Campaigns.swift
//  FrontFlip
//
//  Created by Menan on 2017-01-08.
//  Copyright © 2017 Frontflip. All rights reserved.
//  Data Model of Campaign Objects 

import Foundation
import SwiftKeychainWrapper

class Campaigns {
    
    
    //Private Variables/Properties of a Campaign Object
    private var _campaignKey: String!
    private var _campaignName: String!
    private var _campaginImageUrl: String!
    private var _brandName: String!
    private var _brandImageUrl: String!
    private var _campaignDesc: String!
    private var _confirmImageUrl: String!
    
    
    
    //Get Variables/Properites Of a Campaign Object
    var campaignKey:String{
        return _campaignKey
    }
    
    var campaignName:String {
        return _campaignName
    }
    var campaignImageUrl:String {
        return _campaginImageUrl
    }
    var brandName:String{
        return _brandName
    }
    var brandImageUrl:String{
        return _brandImageUrl
    }
    var campaignDesc:String{
        return _campaignDesc
    }
    var confirmImageUrl:String{
        
     //If there is not a campaign Image Url Set it equal to empty string to be able to check if there is a Url set or not
     if _confirmImageUrl == nil {
            return ""
        } else {
            return _confirmImageUrl
        }
    }
  
    init(campaignKey: String, campaignData: Dictionary<String, AnyObject>) {
        
        //Set Campaign Key
        self._campaignKey = campaignKey
        
        
        //Set the properites from the campaign data that is passed during intialization
        if let campaign_Name = campaignData["campaignName"] as? String {
            self._campaignName = campaign_Name
        }
        
        if let campaign_ImageUrl = campaignData["campaignImageUrl"] as? String {
            self._campaginImageUrl = campaign_ImageUrl
        }
        
        if let brand_Name = campaignData["brandName"] as? String {
            self._brandName = brand_Name
        }
        
        if let brand_ImageUrl = campaignData["brandImageUrl"] as? String {
            self._brandImageUrl = brand_ImageUrl
        }
        if let campaign_Desc = campaignData["campaignDesc"] as? String {
            self._campaignDesc = campaign_Desc
        }
        
        //Parse the campaignData to find the confirmImageUrl: The confirmImageUrl is under "users"(dicitoinary) -> under "currentUserKey"(dicitonariy) -> as "confirmImageUrl"
        if let users = campaignData["user"] as? Dictionary<String, AnyObject> {
            if let user = users[CURRENTUSER!] as? Dictionary<String, AnyObject> {
                if let confirm_ImageUrl = user["confirmImageUrl"] as? String {
                    self._confirmImageUrl = confirm_ImageUrl
                }
            }
        }
    }
    
    
    //Set the campaign confirm url, passing in a URL with type String
    func setConfirmInageUrl(url: String) {
        _confirmImageUrl = url
        print("CheckLa: \(_confirmImageUrl)")
    }
    
    
    
    
    
}
