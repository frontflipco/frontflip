//
//  CampaignsVC.swift
//  FrontFlip
//
//  Created by Menan on 2017-01-08.
//  Copyright © 2017 Frontflip. All rights reserved.
//

import UIKit
import Firebase

class CampaignsVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    //OUTLETS
    @IBOutlet weak var tableView: UITableView!

    var campaigns = [Campaigns]()
    
    static var imageCache: NSCache <NSString, UIImage> = NSCache()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        tableView.delegate = self
        tableView.dataSource = self

        DataService.ds.DATABASE_BASE_CAMPAIGNS.observe(.value, with: { (snapshot) in
            print("menan:\(snapshot.value!)")
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                self.campaigns = []
                for snap in snapshot {
                    if let campaignData = snap.value as? Dictionary <String, AnyObject> {
                        let key = snap.key
                        let campaign = Campaigns(campaignKey: key, campaignData: campaignData)
                        print("menan: \(campaignData)")
                        self.campaigns.append(campaign)
                    }
                }
            }
            self.tableView.reloadData()
        })
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return campaigns.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "campaignCell", for: indexPath) as? CampaignCell {
            
            let campaign = campaigns[indexPath.row]
            
            if let campaignImg = CampaignsVC.imageCache.object(forKey: campaign.campaignImageUrl as NSString), let brandImg = CampaignsVC.imageCache.object(forKey: campaign.brandImageUrl as NSString){
                
                cell.configureCell(campaign: campaign,brandImage: brandImg ,campaignImage: campaignImg)
                return cell
            } else {
                cell.configureCell(campaign: campaign)
                return cell
            }
        } else {
            return CampaignCell()
        }
        
    }
    
    
}
