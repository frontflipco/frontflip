//
//  CampaignCell.swift
//  FrontFlip
//
//  Created by Menan on 2017-01-08.
//  Copyright © 2017 Frontflip. All rights reserved.
//  TableViewCell for a Campaign

import UIKit
import Firebase
import Foundation

class CampaignCell: UITableViewCell{
    
    //OUTLETS
    @IBOutlet weak var brandNameLbl: UILabel!
    
    @IBOutlet weak var campaignNameLbl: UILabel!
    
    @IBOutlet weak var campaignImage: UIImageView!
    
    @IBOutlet weak var brandImage: UIImageView!
    
    @IBOutlet weak var campaignPlatformImage: UIImageView!
    
    @IBOutlet weak var campaignDesc: UITextView!

    @IBOutlet weak var confirmImage: UIImageView!

    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var downArrow: BlinkingButton!
    
    @IBOutlet weak var upArrow: BlinkingButton!
    
    
    
    //Variables
    var campaignKey: String!
    
    var confirmImageUrl: String!
    
    var campaign: Campaigns!
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        
        //Set the Cell Frame to the frames full width: Doing this to make the size of one cell the full screen
        set (newFrame) {
            var frame = newFrame
            let newWidth = frame.width
            let space = (frame.width - newWidth) / 2
            frame.size.width = newWidth
            frame.origin.x += space
            
            super.frame = frame
            
        }
    }
    
    
    // Loading the data into the cell: Onky requirement to be passed in is a campagin, loading of a the cell dependent on if the images are being passed in
    func configureCell(campaign: Campaigns, brandImage: UIImage? = nil, campaignImage: UIImage? = nil, confirmImage: UIImage? = nil ) {
        
        
        //Set the data received from the campaign passed in: Will be required for all cases, TODO: May need to check if the camapgin has the data properties we are setting
        brandNameLbl.text = campaign.brandName
        campaignNameLbl.text = campaign.campaignName
        campaignPlatformImage.image = UIImage(named: "instagram")
        campaignDesc.text = campaign.campaignDesc
        campaignKey = campaign.campaignKey

        
        //SETTING CAMPAIGN IMAGE
        //Set Campagin image if there is one passed
        if campaignImage != nil  {
            self.campaignImage.image = campaignImage
        }
            
        //Set Campaing image if there was no image passed in by loading it from Firebase Storage
        else {
            //Reference to storage from the campaignImageUrl
            let ref = FIRStorage.storage().reference(forURL: campaign.campaignImageUrl)
            //Download the data from Storagebase
            ref.data(withMaxSize: 2 * 1024 * 1024, completion: { (data, error) in
                if error != nil {
                    //TODO: LOADING FROM STORAGE IS UNSUCCESSFUL
                }
                //If download from firebase is successfull
                else {
                    if let campaignImageData = data {
                        // Create a UIImage from the data downloaded
                        if let campaign_Image = UIImage(data: campaignImageData){
                            //Set CampaignCell Image to UIImage Created
                            self.campaignImage.image = campaign_Image
                            // Cache the Image for faster and effienct network loading.
                            CampaignsVC.imageCache.setObject(campaign_Image, forKey: campaign.campaignImageUrl as NSString)
                        }
                    }
                }
            })
        }
        
        
        //SETING BRAND IMAGE
        //Set BrandImage if one is passed in
        if brandImage != nil  {
            self.brandImage.image = brandImage
        }
        //Set Brand Image if there is no image passed in by loading from Firebase
        else {
            
            //Reference to the Firebase Storage with the brandImageUrl
            let ref = FIRStorage.storage().reference(forURL: campaign.brandImageUrl)
            //Download the data from Storagebase
            ref.data(withMaxSize: 2 * 1024 * 1024, completion: { (data, error) in
                if error != nil {
                    //TODO LOADING FROM STORAGE IS UNSUCCESSFUL
                }
                //If downloading the brandImage was successful
                else {
                    if let brandImageData = data {
                        //Create a UIImage from the data downloaded
                        if let brand_Image = UIImage(data: brandImageData){
                            //Set the UIImage Created As the brandImage
                            self.brandImage.image = brand_Image
                            // Cache the Image for faster and effient network loading.
                            CampaignsVC.imageCache.setObject(brand_Image, forKey: campaign.brandImageUrl as NSString)
                        }
                    }
                }
            })
        }
        
        //SETTING CONFIRM IMAGE
        //Set Confirm Image if one is passed in
        if confirmImage != nil {
            self.confirmImage.image = confirmImage
            print("MENAN: \(campaign.brandName) and got that there is confirmImageUrl in the cache")
        }
        //Set Confirm Image if no image was passed in
        else {
            //If the campaign has a confirmImageUrl is set, then set the confirmImage by downloading from Firebase
            if campaign.confirmImageUrl != "" {
                self.confirmImageUrl = campaign.confirmImageUrl
                //Reference to the Firebase Storage from the confirmImageUrl
                let ref = FIRStorage.storage().reference(forURL: self.confirmImageUrl)
                //Download the data from Firebase Storage
                ref.data(withMaxSize: 2 * 1024 * 1024, completion: { (data, error) in
                    if error != nil {
                        //TODO LOADING FROM STORAGE IS UNSUCCESSFUL
                    }
                    //If Downloading the image was successful
                    else {
                        if let confirmImageData = data {
                            //Create a UIImage from the data downloaded from Firebase Storage
                            if let confirm_Image = UIImage(data: confirmImageData){
                                //Set the confirmImage to the UIImage created, and set the status label
                                self.confirmImage.image = confirm_Image
                                self.statusLabel.text = "Requested"
                                self.statusLabel.textColor = UIColor.green
                                self.statusLabel.isHidden = false
                                // Cache the Image for faster and effient network loading.
                                CampaignsVC.imageCache.setObject(confirm_Image, forKey: campaign.confirmImageUrl as NSString)
                            }
                        }
                    }
                })
            }
            //IF the campaign has no confirmImage passed in AND has no confirmImageUrl set: USER HAS NOT REQUESTED TO JOIN THE CAMPAIGN
            else {
                print("MENAN: \(campaign.brandName) and got that there is no confirmImageUrl")
                let image = UIImage(named: "addConfirmImage")
                self.confirmImage.image = image
                self.statusLabel.isHidden = true
            }
        }
    }
    
    //FUNCTIONS FOR THE ARROW INDICATORS
    func hideDownArrowButton() {
        self.downArrow.isHidden = true
        self.upArrow.isHidden = false
    }
   
    func hideUpArrowButton() {
        self.upArrow.isHidden = true
        self.downArrow.isHidden = false
    }
}
