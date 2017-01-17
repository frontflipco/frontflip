//
//  CampaignsVC.swift
//  FrontFlip
//
//  Created by Menan on 2017-01-08.
//  Copyright © 2017 Frontflip. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class CampaignsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //OUTLETS
    @IBOutlet weak var tableView: UITableView!

    //Data Model
    var campaigns = [Campaigns]()

    //Variables
    var imageSelected = false
    var imagePicker: UIImagePickerController!
    var currentCell: CampaignCell!
    static var imageCache: NSCache <NSString, UIImage> = NSCache()

    override func viewDidLoad() {
        super.viewDidLoad()
      

        //tableView Setup
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isPagingEnabled = true
        
        //imagePicker Setup
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
      
        //Check and update changed from the database Campaign endpoint to the tableView
        DataService.ds.DATABASE_BASE_CAMPAIGNS.observe(.value, with: { (snapshot) in
            //Get Snapshot of all children Objects in the Campaign endpoint
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                //Reset the Campaigns Array
                self.campaigns = []
                //For every campaing(snap) in the snapshot
                for snap in snapshot {
                    //Get the campaign Data
                    if let campaignData = snap.value as? Dictionary <String, AnyObject> {
                        //Get the key from the campaign
                        let key = snap.key
                        //Create a campaign object if a campgin is created
                        let campaign = Campaigns(campaignKey: key, campaignData: campaignData)
                        
                        //If a user has requested this campaign before
                        if let users = campaignData["users"] as? Dictionary <String, AnyObject> {
                            //If the current user has requested this campaign before
                            if let user = users[CURRENTUSER!] as? Dictionary <String, AnyObject> {
                                //check to see if the current user has a confirmImageurl
                                if let confirmImageUrl = user["confirmImageUrl"] as? String {
                                    //Set campaign confirmImageUrl
                                    campaign.setConfirmInageUrl(url: confirmImageUrl)
                                }
                            }
                        }
                        //Add campaign to the campaigns array
                        self.campaigns.append(campaign)
                    }
                }
            }
            //Reload TableView
            self.tableView.reloadData()
        })
    }

    
    //TableView Delegate Functions
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return campaigns.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //Set TableViewCell to full height
        return tableView.frame.size.height 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Campaing for the indexPath from the campaigns array
        let campaign = campaigns[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "campaignCell", for: indexPath) as? CampaignCell {
            
            //Confirm Image Tap Recongizer To Add Image
            let tap = UITapGestureRecognizer(target: self, action: #selector(confirmImagePressed))
            tap.numberOfTapsRequired = 1
            cell.confirmImage.addGestureRecognizer(tap)
            cell.confirmImage.isUserInteractionEnabled = true
            //Store the indexPath of the confirmImage in the images tag
            cell.confirmImage.tag = indexPath.row
            
            //if campaign Im and Brand Image are cached
            if let campaignImg = CampaignsVC.imageCache.object(forKey: campaign.campaignImageUrl as NSString), let brandImg = CampaignsVC.imageCache.object(forKey: campaign.brandImageUrl as NSString){
                //if confirmImage is cached
                if let confirmImg = CampaignsVC.imageCache.object(forKey: campaign.confirmImageUrl as NSString) {
                    cell.configureCell(campaign: campaign,brandImage: brandImg ,campaignImage: campaignImg, confirmImage: confirmImg)
                }
                else {
                    cell.configureCell(campaign: campaign,brandImage: brandImg ,campaignImage: campaignImg)
                }
            }
            // If confirm Image, Brand Image and Confirm Image are not cached
            else {
                cell.configureCell(campaign: campaign)
            }
            
            //Set Arrow Indicator depdent on cells position
            switch indexPath.row {
               
            //First Cell
            case 0:
                cell.hideUpArrowButton()
                print("MenanLOOKUP: GOT HERE FIRST")
                print("MenanLOOKUP: \(indexPath.row), \(indexPath.row) , \(cell.brandNameLbl.text)")
                
            //Last Cell
            case self.tableView(tableView, numberOfRowsInSection: 0) - 1:
                cell.hideDownArrowButton()
                print("MenanLOOKUP: GOT HERE LAST, \(indexPath.row) , \(cell.brandNameLbl.text)")
             
            //Cell in the middle
            default:
                print("MenanLOOKUP: GOT HERE NONE")
                print("MenanLOOKUP: \(indexPath.row), \(indexPath.row) , \(cell.brandNameLbl.text)")
                break
            }
            return cell
        }
        
        // If dequeing cell with idneitifer fails
        else {
            
            return CampaignCell()
        }
    }
    
    //ACTIONS
    @IBAction func logOffPressed(_ sender: Any) {
        
        let removeSuccessful: Bool = KeychainWrapper.standard.remove(key: KEY_UID)
        if removeSuccessful {
            CURRENTUSER = nil
            //TODO: Remove Image Cache
            performSegue(withIdentifier: GOTOLOGIN, sender: nil)
        }
    }
    
    //FUNCTIONS
    func confirmImagePressed(sender: UITapGestureRecognizer) {
        
        //Check sender
        if let confirmImageView = sender.view {
            //Get the indexPath Row from imageView tag
            let row = confirmImageView.tag as Int
            //Create a indexPath from the row
            let indexPath = IndexPath(row: row , section: 0)
            //Get cell at the indexpath
            if let cell = self.tableView.cellForRow(at: indexPath) as? CampaignCell{
                //Set the current cell to the cell at the indexpath
                currentCell = cell
                
            }
            //Show Image Picker
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        //If a image was picked
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            //Format the image to JPEG and compress .2
            let formattedImage = UIImageJPEGRepresentation(image, 0.2)
            let imgId = NSUUID().uuidString
            let metaData = FIRStorageMetadata()
            metaData.contentType = "image/jpeg"
            
            //Store Image in Firebase Storage
            DataService.ds.STORAGEBASE_BASE_CONFIRM_IMAGE.child(imgId).put(formattedImage!, metadata: metaData) {(metaData, error) in
                if error != nil {
                    //TODO: SHOW ERROR WHEN UPLOADING CONFIRM IMAGE
                } else {
                    //REMOVE PREVIOUS IMAGE FROM STORAGE
                    if self.currentCell.confirmImageUrl != "" && self.currentCell.confirmImageUrl != nil {
                        let previousImageRef = FIRStorage.storage().reference(forURL: self.currentCell.confirmImageUrl)
                        previousImageRef.delete(completion: { (error) in
                            if error != nil {
                                // TOOD: Error while deleting previous image
                            } else {
                                //TODO: Succesful while deleting previous image
                            }
                        })
                    }
                    //GET DownloadUrl From uploaded image
                    let downloadUrl = metaData?.downloadURL()?.absoluteString
                    if let url = downloadUrl {
                        self.updateConfirmImageToFireBase(url: url)
                    }
                    self.tableView.reloadData()
                }
            }
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    func updateConfirmImageToFireBase(url: String) {
        
        let confirmImageData: Dictionary<String, Any> = [
            "confirmImageUrl": url
        ]
        
        //Add confirm Url to Firebase
        _ = DataService.ds.DATABASE_BASE_CAMPAIGNS.child(currentCell.campaignKey).child("users").child(CURRENTUSER!).updateChildValues(confirmImageData)
        print("menan check updateFB: updated to firebase")
        
    }
    

    

}
