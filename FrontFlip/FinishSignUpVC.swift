//
//  FinishSignUpVC.swift
//  FrontFlip
//
//  Created by Menan on 2017-01-15.
//  Copyright © 2017 Frontflip. All rights reserved.
//

import UIKit

class FinishSignUpVC: UIViewController {

    //OUTLETS
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var instagramButton: UIButton!
    @IBOutlet weak var twitterButton: UIButton!
    @IBOutlet weak var snapchatButton: UIButton!
    @IBOutlet weak var youtubeButton: UIButton!
    @IBOutlet weak var pinterestButton: UIButton!
    @IBOutlet weak var linkedinButton: UIButton!
    @IBOutlet weak var tumblrButton: UIButton!
    
    //Variabels
    var facebookSelected = false
    var instagramSelected = false
    var twitterSelected = false
    var snapchatSelected = false
    var youtubeSelected = false
    var pinterestSelected = false
    var linkedinSelected = false
    var tumblrSelected = false
    
    //ACTIONS
    //If a button is pressed, show that it is selected and toggle its variable to selected and vice versa TODO: Clean up code
    @IBAction func facebookPressed(_ sender: Any) {
        if self.facebookSelected {
            let image = UIImage(named: "defaultFacebook")
            self.facebookButton.setImage(image, for: .normal)
            self.facebookSelected = false
        } else {
            let image = UIImage(named: "selectedFacebook")
            self.facebookButton.setImage(image, for: .normal)
            self.facebookSelected = true
        }
    }
    
    
    @IBAction func instagramPressed(_ sender: Any) {
        if self.instagramSelected {
            let image = UIImage(named: "defaultInstagram")
            self.instagramButton.setImage(image, for: .normal)
            self.instagramSelected = false
        } else {
            let image = UIImage(named: "selectedInstagram")
            self.instagramButton.setImage(image, for: .normal)
            self.instagramSelected = true
        }
    }
    
    @IBAction func twitterPressed(_ sender: Any) {
        if self.twitterSelected {
            let image = UIImage(named: "defaultTwitter")
            self.twitterButton.setImage(image, for: .normal)
            self.twitterSelected = false
        } else {
            let image = UIImage(named: "selectedTwitter")
            self.twitterButton.setImage(image, for: .normal)
            self.twitterSelected = true
        }
    }
    
    @IBAction func snapchatPressed(_ sender: Any) {
        if self.snapchatSelected {
            let image = UIImage(named: "defaultSnapchat")
            self.snapchatButton.setImage(image, for: .normal)
            self.snapchatSelected = false
        } else {
            let image = UIImage(named: "selectedSnapchat")
            self.snapchatButton.setImage(image, for: .normal)
            self.snapchatSelected = true
        }
    }
    
    @IBAction func youtubePressed(_ sender: Any) {
        if self.youtubeSelected {
            let image = UIImage(named: "defaultYoutube")
            self.youtubeButton.setImage(image, for: .normal)
            self.youtubeSelected = false
        } else {
            let image = UIImage(named: "selectedYoutube")
            self.youtubeButton.setImage(image, for: .normal)
            self.youtubeSelected = true
        }
    }

    
    @IBAction func pinterestPressed(_ sender: Any) {
        if self.pinterestSelected {
            let image = UIImage(named: "defaultPinterest")
            self.pinterestButton.setImage(image, for: .normal)
            self.pinterestSelected = false
        } else {
            let image = UIImage(named: "selectedPinterest")
            self.pinterestButton.setImage(image, for: .normal)
            self.pinterestSelected = true
        }
    }
    
    
    @IBAction func linkedPressed(_ sender: Any) {
        if self.linkedinSelected {
            let image = UIImage(named: "defaultLinkedin")
            self.linkedinButton.setImage(image, for: .normal)
            self.linkedinSelected = false
        } else {
            let image = UIImage(named: "selectedLinkedin")
            self.linkedinButton.setImage(image, for: .normal)
            self.linkedinSelected = true
        }
    }
    
    
    @IBAction func tumblrPressed(_ sender: Any) {
        if self.tumblrSelected {
            let image = UIImage(named: "defaultTumblr")
            self.tumblrButton.setImage(image, for: .normal)
            self.tumblrSelected = false
        } else {
            let image = UIImage(named: "selectedTumblr")
            self.tumblrButton.setImage(image, for: .normal)
            self.tumblrSelected = true
        }
    }
    
    
    @IBAction func finishButtonPressed(_ sender: Any) {
        
        //Create Data from inputs by user
        let socialSiteData: Dictionary<String, Any> = [
            "selectedFacebook": "\(self.facebookSelected)",
            "selectedInstagram": "\(self.instagramSelected)",
            "selectedTwitter": "\(self.twitterSelected)",
            "selectedSnapchat": "\(self.snapchatSelected)",
            "selectedYoutube": "\(self.youtubeSelected)",
            "selectedPinterest": "\(self.pinterestSelected)",
            "selectedLinkedin": "\(self.linkedinSelected)",
            "selectedTumblr": "\(self.tumblrSelected)",
            
        ]
        
        //Update that to the user endpoint in database
        DataService.ds.DATABASE_BASE_USERS.child(CURRENTUSER!).updateChildValues(socialSiteData)
        
        performSegue(withIdentifier: GOTOMAIN, sender: nil)
    }
}
