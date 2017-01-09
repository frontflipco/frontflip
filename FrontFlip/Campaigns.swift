//
//  Campaigns.swift
//  FrontFlip
//
//  Created by Menan on 2017-01-08.
//  Copyright © 2017 Frontflip. All rights reserved.
//

import Foundation

class Campaigns {
    
    private var _campaignKey: String!
    private var _campaignName: String!
    private var _campaginImageUrl: String!
    private var _brandName: String!
    private var _brandImageUrl: String!
    private var _campaignDesc: String!
    
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
  
    init(campaignKey: String, campaignData: Dictionary<String, AnyObject>) {
        
        self._campaignKey = campaignKey
        
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

    }
    
    
    
    
    
    
}
