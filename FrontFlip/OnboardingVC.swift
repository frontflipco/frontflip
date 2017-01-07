//
//  ViewController.swift
//  FrontFlip
//
//  Created by Menan on 2017-01-07.
//  Copyright © 2017 Frontflip. All rights reserved.
//
// This file implements the PaperOnBoarding Framework

import UIKit
import PaperOnboarding

class OnboardingVC: UIViewController, PaperOnboardingDelegate, PaperOnboardingDataSource {

    
    
    //OUTLETS

    @IBOutlet weak var onboardingView: OnboardingView!
    @IBOutlet weak var getStartedBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting the onboardingView Delegate and dataSource to this viewcontroller
        onboardingView.delegate = self
        onboardingView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //Settings the number of pages in the onboarding screen should have
    func onboardingItemsCount() -> Int {
        return 3
    }
    
    //Loads the infomration into the onboarding screen pages
    func onboardingItemAtIndex(_ index: Int) -> OnboardingItemInfo {
        
        //Onboarding Items Common Characteristixs
        let textColor = UIColor.white
        let descriptionColor = UIColor.white
        let titleFont = UIFont(name: "AvenirNext-Bold", size: 24)!
        let descriptionFont = UIFont(name: "AvenirNext-Regular", size: 20)!
        
        //Onboarding Item 1
        let imageNameOne = "onboardingImg1"
        let titleOne = "Onboarding Title One"
        let descriptionOne = "This is the description for FrontFlip Onboarding screen 1"
        let iconNameOne = "iconNameOne"
        let colorOne = UIColor.yellow
        
        //Onboarding Item 2
        let imageNameTwo = "onboardingImg2"
        let titleTwo = "Onboarding Title Two"
        let descriptionTwo = "This is the description for FrontFlip Onboarding screen 2"
        let iconNameTwo = "iconNameTwo"
        let colorTwo = UIColor.blue
        
        //Onboarding Item 3
        let imageNameThree = "onboardingImg3"
        let titleThree = "Onboarding Title Three"
        let descriptionThree = "This is the description for FrontFlip Onboarding screen 3"
        let iconNameThree = "iconNameThree"
        let colorThree = UIColor.red
        
        
        return [(imageNameOne,titleOne,descriptionOne,iconNameOne,colorOne,textColor,descriptionColor,titleFont,descriptionFont),
                (imageNameTwo,titleTwo,descriptionTwo,iconNameTwo,colorTwo,textColor,descriptionColor,titleFont,descriptionFont),
                (imageNameThree,titleThree,descriptionThree,iconNameThree,colorThree,textColor,descriptionColor,titleFont,descriptionFont)][index]
    }
    
    //Mandatory Onboarding Delegate Function, we do not need to use
    func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {
        
    }
    
    //Allows to perform code if the onboarding collection will be transitioned
    func onboardingWillTransitonToIndex(_ index: Int) {
        // If onboardingPage two is transisitioned from page 3  then animate out the get started button
        if index == 1 {
            if self.getStartedBtn.alpha == 1  {
                UIView.animate(withDuration: 0.2, animations: {
                    self.getStartedBtn.alpha = 0
                })
            }
        }
    }
    //Allows to perform code if the onboarding collection has been transitioned
    func onboardingDidTransitonToIndex(_ index: Int) {
        // If onboardingPage three is transisitioned to then animate in the get started button
        if index == 2 {
            UIView.animate(withDuration: 0.2, animations: {
                self.getStartedBtn.alpha = 1
            })
        }
    }
    
    //when get started button is presesd
    @IBAction func getStartedBtnPressed(_ sender: Any) {
        
        //Setting the onboarding has finished and saving to userdefaults
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: "OnboardingComplete")
        userDefaults.synchronize()
        
        
    }
    
    
    
    
}

