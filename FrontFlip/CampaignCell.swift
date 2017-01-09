//
//  CampaignCell.swift
//  FrontFlip
//
//  Created by Menan on 2017-01-08.
//  Copyright © 2017 Frontflip. All rights reserved.
//

import UIKit
import Firebase

class CampaignCell: UITableViewCell {
    
    //OUTLETS
    
    @IBOutlet weak var brandNameLbl: UILabel!
    
    @IBOutlet weak var campaignNameLbl: UILabel!
    
    @IBOutlet weak var campaignImage: UIImageView!
    
    @IBOutlet weak var brandImage: UIImageView!
    
    @IBOutlet weak var campaignPlatformImage: UIImageView!
    
    
    @IBOutlet weak var campaignDesc: UITextView!

    var campaign: Campaigns!
    
    
    
    func configureCell(campaign: Campaigns, brandImage: UIImage? = nil, campaignImage: UIImage? = nil ) {
        
        brandNameLbl.text = campaign.brandName
        campaignNameLbl.text = campaign.campaignName
        campaignPlatformImage.image = UIImage(named: "instagram")
        //TODO Set Campagin image
        if brandImage != nil {
            self.brandImage.image = brandImage
        } else {
            
        }
        
        
        if campaignImage != nil  {
            self.campaignImage.image = campaignImage
        } else {
            let ref = FIRStorage.storage().reference(forURL: campaign.campaignImageUrl)
            ref.data(withMaxSize: 2 * 1024 * 1024, completion: { (data, error) in
                if error != nil {
                    //TODO LOADING FROM STORAGE IS UNSUCCESSFUL
                }else {
                    if let campaignImageData = data {
                        if let campaign_Image = UIImage(data: campaignImageData){
                            self.campaignImage.image = campaign_Image
                            CampaignsVC.imageCache.setObject(campaign_Image, forKey: campaign.campaignImageUrl as NSString)
                        }
                    }
                }
            })
        }
        

        //TODO Set Brand image
        if brandImage != nil  {
            self.brandImage.image = brandImage
        } else {
            let ref = FIRStorage.storage().reference(forURL: campaign.brandImageUrl)
            ref.data(withMaxSize: 2 * 1024 * 1024, completion: { (data, error) in
                if error != nil {
                    //TODO LOADING FROM STORAGE IS UNSUCCESSFUL
                }else {
                    if let brandImageData = data {
                        if let brand_Image = UIImage(data: brandImageData){
                            self.brandImage.image = brand_Image
                            CampaignsVC.imageCache.setObject(brand_Image, forKey: campaign.brandImageUrl as NSString)
                        }
                    }
                }
            })
        }
       
        campaignDesc.text = campaign.campaignDesc

    }
    
    
    
    
}
